Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD81381E5
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jan 2020 15:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgAKO6A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jan 2020 09:58:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50158 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730149AbgAKO5h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jan 2020 09:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578754656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7qjy9xbiaLG7WRsoNLzShcjgZHsU7KBsnk3kgwPRLlc=;
        b=LtyDeFF4NPEofNwqsHG2n5due3jnQfSgVt7ekOgHvVI2E9FepxiqxrnZbdFGacygpVDoXr
        a1Y/QP6mf6oCZdVEO4YbqghSaByGsaOj2oLdJy1DBmjoZqanNinbqVAh7tkX0VqAuTLzPy
        3JjsA1MOHyoBA1tNNqFN6uVqWXxmVbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-rCXvitP5Ndmnijv-dMacdQ-1; Sat, 11 Jan 2020 09:57:34 -0500
X-MC-Unique: rCXvitP5Ndmnijv-dMacdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B2E9801E70;
        Sat, 11 Jan 2020 14:57:32 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-84.ams2.redhat.com [10.36.116.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5D948177F;
        Sat, 11 Jan 2020 14:57:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v11 06/10] selftests: firmware: Add firmware_request_platform tests
Date:   Sat, 11 Jan 2020 15:56:59 +0100
Message-Id: <20200111145703.533809-7-hdegoede@redhat.com>
In-Reply-To: <20200111145703.533809-1-hdegoede@redhat.com>
References: <20200111145703.533809-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add tests cases for checking the new firmware_request_platform api.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../selftests/firmware/fw_filesystem.sh       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/te=
sting/selftests/firmware/fw_filesystem.sh
index 56894477c8bd..fcc281373b4d 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -86,6 +86,29 @@ else
 	fi
 fi
=20
+# Try platform (EFI embedded fw) loading too
+if [ ! -e "$DIR"/trigger_request_platform ]; then
+	echo "$0: firmware loading: platform trigger not present, ignoring test=
" >&2
+else
+	if printf '\000' >"$DIR"/trigger_request_platform 2> /dev/null; then
+		echo "$0: empty filename should not succeed (platform)" >&2
+		exit 1
+	fi
+
+	# Note we echo a non-existing name, since files on the file-system
+	# are preferred over firmware embedded inside the platform's firmware
+	# The test adds a fake entry with the requested name to the platform's
+	# fw list, so the name does not matter as long as it does not exist
+	if ! echo -n "nope-$NAME" >"$DIR"/trigger_request_platform ; then
+		echo "$0: could not trigger request platform" >&2
+		exit 1
+	fi
+
+	# The test verifies itself that the loaded firmware contents matches
+	# the contents for the fake platform fw entry it added.
+	echo "$0: platform loading works"
+fi
+
 ### Batched requests tests
 test_config_present()
 {
--=20
2.24.1

