Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E404E16874F
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 20:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgBUTSi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 14:18:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:50969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgBUTSi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 14:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582312714;
        bh=Nq85DrtKzSXKfwb6vz49+YhiGD+iT9Q5RUtxJ2jJoXc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LlZTVYlWK89DpP5g6yOlOJJ8N1e7J1SaWWTaqcwoT9GgFE9Gi00dKjbGzqdyBh0Dq
         DBDJP+fhH2SzFbaNGiKREXGpOGjwiZ5vmZG5wN61L/XG1YkPogpe1kbVj555tDN78n
         +TDklW4J7AG0f6xIaduP6+gXJyAbYpg7XWxUu+fg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCKBc-1jEXUZ3Dne-009Pxy; Fri, 21
 Feb 2020 20:18:33 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: error message in handle_cmdline_files()
Date:   Fri, 21 Feb 2020 20:18:29 +0100
Message-Id: <20200221191829.18149-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ycPl9JvoBhgdTMmldjA76dcB1rPEEbh8gko8LaEbQuGzIGCqnyI
 GukskLxIAEQfcKCkQQIUD+9Lpahe+3demcG4iep5guTrwOELDn5p1Gzzy62Zb89/oxl8f7B
 nC+FLtj/qIvXB7UgrOS6r2w1sxcE/lRU/kOCs+am86pt8bx8MCclqzLDefgiUFWvmbVx9Io
 F39mMHyLXubVFOhUrIR5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oe9SAzEVDjc=:/TsCzLQ47OFf8pTe73krY9
 7gBTD8KSZdL94/fGAQl9HaPrsAdyzY9WssUi67lFnGMGvSHa5/YVA/NZ73c8wPWbqYTQxc/ze
 EknbLTjxrQxBd3NomN2yxPNhRb06KS0VI8t7zm03h4xAMEIn5RbPTjmuwEeOnotqiDUSn3kC3
 Q2amF6wSdOGXzRofqwQNDlF5g7nFnyTtLegzfgywPQxJzu+89lOsV4ycT318N9kMpecaMWKdl
 AqHP0Ibe5kxtgCVI47nyVFKRpFtKc+18kbqF/uhn2cpl/iL0Iggr+rVCO8SC4EgpwOkKhs7/3
 FnbRVRyK3cqQvuYwVabpqeQpmSkIGsaqRcxRGdI+B3miO8TRP+prA0cQVxWOlUQsmGUu9JoZX
 uIJh0ePIo1vqeyJCKVWd+un+1VsBXGYDAuoSaK75CqD26wVJYR9T+POlg9VJxnkclW23L9NX7
 Q9sk52qNhEJydu0wWZL2x7YSSkrVqlEcQEFhPxQxoLObdqE9G86sYg3QYjlHYGgyS9yh92wJo
 icGHDjFQaNWqi1ez3pBAfTWmrskx4EUsvywio74AVDbAeXrx/06/uyuydiARF5GnTmuyB2jBS
 S76+X5fCZ9ft89NUdHRBrpbKoyybdIvTOqq/GP1zEBxrFkDBuP8cZMkHtSrA5hLu+nbpTRx5d
 ItXdWxzciUpPJxprqi9jmNWHL3qqnSCmi8yZKI7+slocA4tKwgx/DzkmWlUB5CN16vixux7B+
 50Vew0ffi+vP2rqGhGYwqXhkxHXyJciYrDhzrSoWFWElOHa47f5PllZ+1lFzqw7paa/QSF3T2
 gqI7xKzm8UPerIxkGTacbvGJc35c8rKN1u1tS/vKp2wnDY0UQv1B2BaW6ylv46y4jHg/krIqk
 crBbYCZiCClxWMdCo5s7JxJ6xOBI+Tat0+cKMhg5cQ9BV8FTMxzvSZWWqKdJqV/nHCp46iAU7
 TLy/IqrXfr95HIBuX3NezmRhdxWnQdOIFpJo2A6bIEa1dgqTT9HGemkpaf82GeEYSV2kwnFvV
 EWkZwp9X2S30m+aHFV4elarpiViCPfh87NzHztzD2tdE6STnatCcMxvaqH/XD0vQsd0QJZWFc
 /cS3Nm7OAAjS5Bl3kkTdgN1TkhaJ1TmLk+2jMVLuO5WfGFK8WH9cexcvU3N3ozqmaRR7IdagF
 WGMaFqNaq/PEk2nAQWyBVg6lXvpBgOZBNGzlJNClnCh9W/UzZ9FnGBWkrwivXlXBZ0uGwpWyy
 47ry29G0ky8nuUlR9
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The memory for files is allocated not reallocated.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/libstub/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/li=
bstub/file.c
index be78f64f8d80..d4c7e5f59d2c 100644
=2D-- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -190,7 +190,7 @@ static efi_status_t handle_cmdline_files(efi_loaded_im=
age_t *image,
 							    &alloc_addr,
 							    hard_limit);
 			if (status !=3D EFI_SUCCESS) {
-				pr_efi_err("Failed to reallocate memory for files\n");
+				pr_efi_err("Failed to allocate memory for files\n");
 				goto err_close_file;
 			}

=2D-
2.25.0

