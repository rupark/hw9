import { Row, Col, Form, Button } from 'react-bootstrap';
import { useState } from 'react';
import { useHistory } from 'react-router-dom';

import { create_post, fetch_posts } from '../api';

export default function PostsNew() {
  let history = useHistory();
  let [post, setPost] = useState({});
  let [invites, setInvites] = useState([]);

  let inviteList = invites.map((invite) => (
    <tr key={invite.id}>
      <td>{invite.user_id}</td>
      <td>
        [ Edit ]
      </td>
    </tr>
  ));

  function submit(ev) {
    ev.preventDefault();
    console.log(ev);
    console.log(post);
    create_post(post).then((resp) => {
      if (resp["errors"]) {
        console.log("errors", resp.errors);
      }
      else {
        history.push("/");
        fetch_posts();
      }
    });
  }

  function updatePhoto(ev) {
    let p1 = Object.assign({}, post);
    p1["photo"] = ev.target.files[0];
    setPost(p1);
  }

  function updateBody(ev) {
    let p1 = Object.assign({}, post);
    p1["body"] = ev.target.value;
    setPost(p1);
  }

  function updateDate(ev) {
    let p1 = Object.assign({}, post);
    p1["date"] = ev.target.value;
    setPost(p1);
  }

  function updateTitle(ev) {
    let p1 = Object.assign({}, post);
    p1["title"] = ev.target.value;
    setPost(p1);
  }

  function addInvite(ev) {
    console.log(ev.target.value)
    setInvites(invites.push(ev.target.value))
    let p1 = Object.assign({}, post);
    p1["invites"] = invites;
    setPost(p1);
  }

  return (
    <Row>
      <Col>

        <h2>New Post</h2>
        <Form onSubmit={submit}>
          <Form.Group>
            <Form.Label>Date</Form.Label>
            <Form.Control as="textarea"
                          rows={1}
                          onChange={updateDate}
                          value={post.date} />
            <Form.Label>Title</Form.Label>
            <Form.Control as="textarea"
                          rows={1}
                          onChange={updateTitle}
                          value={post.title} />
            <Form.Label>Text</Form.Label>
            <Form.Control as="textarea"
                          rows={4}
                          onChange={updateBody}
                          value={post.body} />
          </Form.Group>
          <Button variant="primary" type="submit">
            Post!
          </Button>
        </Form>

        <Form onSubmit={addInvite}>
          <Form.Group>
            <Form.Label>Invite</Form.Label>
            <Form.Control as="textarea"
                          rows={1}
                          onSubmit={addInvite} />
          </Form.Group>
          <Button variant="primary">
            Invite
          </Button>

        </Form>
        <table>
          <tbody>
            { inviteList}
          </tbody>
        </table>
      </Col>
    </Row>
  );
}
