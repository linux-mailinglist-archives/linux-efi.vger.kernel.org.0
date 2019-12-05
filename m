Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6D114730
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfLESpN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 13:45:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730183AbfLESpN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 13:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575571512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVYI3Cyf0iNefbb75CJSebcgOumNQNbDN8xNdVc1X/Q=;
        b=Zba8Yry4pjv0L84K9HSzpQ0hDvrbIBENXy76aZ1NPmtxJzZFO3sUmj1nQt6vyrKpX2Xa06
        sC+1CsOajXz4XrVfburqrXShM1NWnSyTES5WR6yDK9gZWRiaex+J6YL38417ONMMMTOdmk
        VDSB4ChUYUcLP2NHh3XDN1b3tbPWxWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-Y1sQw2uOPACNS76pAukFkw-1; Thu, 05 Dec 2019 13:45:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 520C21005510;
        Thu,  5 Dec 2019 18:45:06 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-55.ams2.redhat.com [10.36.116.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74DD5600D1;
        Thu,  5 Dec 2019 18:44:59 +0000 (UTC)
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
Subject: [PATCH v9 06/10] selftests: firmware: Add firmware_request_platform tests
Date:   Thu,  5 Dec 2019 19:44:18 +0100
Message-Id: <20191205184422.7316-7-hdegoede@redhat.com>
In-Reply-To: <20191205184422.7316-1-hdegoede@redhat.com>
References: <20191205184422.7316-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Y1sQw2uOPACNS76pAukFkw-1
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

