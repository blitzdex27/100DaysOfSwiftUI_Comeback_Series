//
//  UserDetailView.swift
//  17_Milestone_project-10-12
//
//  Created by Dexter  on 6/24/24.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    var body: some View {
        Text(user.name ?? "Anonymouse")
    }
}

#Preview {
    UserDetailView()
}
