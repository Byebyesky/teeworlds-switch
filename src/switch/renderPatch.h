void glOrtho(float left, float right, float bottom, float top, float nearVal, float farVal) {
    GLfloat orthMatrix[4][4] = {2.f,0.f,0.f,0.f,
								0.f,2.f,0.f,0.f,
								0.f,0.f,2.f,0.f,
								-((right+left)/(right-left)),-((top+bottom)/(top-bottom)),-((farVal+nearVal)/(farVal-nearVal)),1.f
						};
	
	orthMatrix[0][0] = static_cast<float>(2) / static_cast<float>(right - left);
	orthMatrix[1][1] = static_cast<float>(2) / static_cast<float>(top - bottom);
    orthMatrix[2][2] = static_cast<float>(-2) / static_cast<float>(farVal - nearVal);
	glMultMatrixf((GLfloat*)orthMatrix);
}