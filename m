Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5600311875C
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2019 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfLJLwX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 06:52:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28383 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727784AbfLJLv4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Dec 2019 06:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575978715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVYI3Cyf0iNefbb75CJSebcgOumNQNbDN8xNdVc1X/Q=;
        b=MIfhd6N38+Fbf+krSzJUo728D1KwPp++l7phTeqt9jVxPVosHJgras0jLTINeoIrVFpVDQ
        ic7QgIWZ0Xg+mvD7lBxTo2+6NL5ozp41ooBa5d9kAD5+QboGaA2ViXJrWLbjOSlBk91rfY
        V3DEBWIIjtdLEDBfrqFTZi+WUE1Z3xA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-q712hvhTPOqBpKF6r6cXrw-1; Tue, 10 Dec 2019 06:51:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA52F18044B5;
        Tue, 10 Dec 2019 11:51:48 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 377465DA60;
        Tue, 10 Dec 2019 11:51:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH v10 06/10] selftests: firmware: Add firmware_request_platform tests
Date:   Tue, 10 Dec 2019 12:51:13 +0100
Message-Id: <20191210115117.303935-7-hdegoede@redhat.com>
In-Reply-To: <20191210115117.303935-1-hdegoede@redhat.com>
References: <20191210115117.303935-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: q712hvhTPOqBpKF6r6cXrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/test=
ing/selftests/firmware/fw_filesystem.sh
index 56894477c8bd..fcc281373b4d 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -86,6 +86,29 @@ else
 =09fi
 fi
=20
+# Try platform (EFI embedded fw) loading too
+if [ ! -e "$DIR"/trigger_request_platform ]; then
+=09echo "$0: firmware loading: platform trigger not present, ignoring test=
" >&2
+else
+=09if printf '\000' >"$DIR"/trigger_request_platform 2> /dev/null; then
+=09=09echo "$0: empty filename should not succeed (platform)" >&2
+=09=09exit 1
+=09fi
+
+=09# Note we echo a non-existing name, since files on the file-system
+=09# are preferred over firmware embedded inside the platform's firmware
+=09# The test adds a fake entry with the requested name to the platform's
+=09# fw list, so the name does not matter as long as it does not exist
+=09if ! echo -n "nope-$NAME" >"$DIR"/trigger_request_platform ; then
+=09=09echo "$0: could not trigger request platform" >&2
+=09=09exit 1
+=09fi
+
+=09# The test verifies itself that the loaded firmware contents matches
+=09# the contents for the fake platform fw entry it added.
+=09echo "$0: platform loading works"
+fi
+
 ### Batched requests tests
 test_config_present()
 {
--=20
2.23.0

