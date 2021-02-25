from minikube.helloworld.main import app

def test_helloworld():
    response = app.test_client().get('/')
    assert response.status_code == 200
    assert response.data == 'Hello World from None'