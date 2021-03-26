
import { Row, Col, Card } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';

function Post({post}) {
  console.log(post)
  let postLink = "/posts/" + post.id;
  let editLink = "/posts/edit";
  return (
    <Col md="3">
      <Card>
        <Card.Text>
          Posted by {post.user.name} <br/>
          Title: {post.title} <br/>
          Date: {post.date} <br/>
          <Link to={postLink}>Show</Link> <Link to={editLink}>Edit</Link>
        </Card.Text>
      </Card>
    </Col>
  );
}

function Feed({posts, session}) {
  let cards = posts.map((post) => (
    <Post post={post} key={post.id} />
  ));

  let new_link = null;
  let edit_link = null;
  if (session) {
    new_link = (
      <p><Link to="/posts/new">New Post</Link></p>
    )
  }

  return (
    <div>
      <h2>Feed</h2>
      { new_link }
      <Row>{cards}</Row>
    </div>
  );
}

export default connect(
  ({posts, session}) => ({posts, session}))(Feed);
