Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB217A18C
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 09:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgCEIl5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 03:41:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40691 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgCEIl5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 03:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583397716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lvGyLMLbn4ylBoP2RsTzaqAcqw4HeX+JB/H+P3l+b8=;
        b=Lg0+fmtoMIeLxOQNHCYEFclVHtBKPERy8bgkDRaVmd2pvoo/oscuXnsT+DwoBoMZJ8r3vO
        dK7Kl4s6uuPy4OSVbz2gxd7x62jSqJEl+taDoMGWuN5KufRahORpC384qGdnXTbpjY/s5o
        Ddd34khuM+B30Du/uP9Fl2SpSYQ2GFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-9g2vDRckN5mHt24YZVwaKQ-1; Thu, 05 Mar 2020 03:41:54 -0500
X-MC-Unique: 9g2vDRckN5mHt24YZVwaKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88C4D8017CC;
        Thu,  5 Mar 2020 08:41:53 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-204-231.brq.redhat.com [10.40.204.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE17046;
        Thu,  5 Mar 2020 08:41:49 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        joeyli <jlee@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] efi: fix a mistype in comments mentioning efivar_entry_iter_begin()
Date:   Thu,  5 Mar 2020 09:40:41 +0100
Message-Id: <20200305084041.24053-4-vdronov@redhat.com>
In-Reply-To: <20200305084041.24053-1-vdronov@redhat.com>
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <20200305084041.24053-1-vdronov@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 drivers/firmware/efi/efi-pstore.c | 2 +-
 drivers/firmware/efi/vars.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi=
-pstore.c
index 9ea13e8d12ec..e4767a7ce973 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct efivar_e=
ntry *pos,
  *
  * @record: pstore record to pass to callback
  *
- * You MUST call efivar_enter_iter_begin() before this function, and
+ * You MUST call efivar_entry_iter_begin() before this function, and
  * efivar_entry_iter_end() afterwards.
  *
  */
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 436d1776bc7b..5f2a4d162795 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1071,7 +1071,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
  * entry on the list. It is safe for @func to remove entries in the
  * list via efivar_entry_delete().
  *
- * You MUST call efivar_enter_iter_begin() before this function, and
+ * You MUST call efivar_entry_iter_begin() before this function, and
  * efivar_entry_iter_end() afterwards.
  *
  * It is possible to begin iteration from an arbitrary entry within
--=20
2.20.1

