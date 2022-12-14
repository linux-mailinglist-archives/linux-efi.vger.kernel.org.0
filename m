Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280AD64D1D0
	for <lists+linux-efi@lfdr.de>; Wed, 14 Dec 2022 22:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLNVbY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Dec 2022 16:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLNVbV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Dec 2022 16:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E64E36D76
        for <linux-efi@vger.kernel.org>; Wed, 14 Dec 2022 13:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671053433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=Mdh/7bm9+wtoe4Hd6cIEdts3EB320ZBGLuixnqSySc4=;
        b=Ux9lPLL2veBPISn6wX+oivS3u0x1uzc7z9M/uhDksglq3uIb3cU1E7J6lWXgaLtmak2eKy
        leHcfk76+LvetF4s3UXDyf67Ka9fCPJSziF53dXTg11X6JR1sXXnC1Ke0NxLjx4RtkBX5Q
        YXIBspROBkSnl8j1WL2BTwwC5U000gM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-IqaeJKWGP4G4fO6D5GFzqA-1; Wed, 14 Dec 2022 16:30:29 -0500
X-MC-Unique: IqaeJKWGP4G4fO6D5GFzqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0733C80D0E5;
        Wed, 14 Dec 2022 21:30:29 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 614D414171BE;
        Wed, 14 Dec 2022 21:30:28 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efitools: Include <strings.h> for the strcasecmp function
Date:   Wed, 14 Dec 2022 22:30:26 +0100
Message-ID: <87pmcllll9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Otherwise, an implicit function declaration is the result, and the
code may fail to compile with future compilers.

---
 efi-updatevar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/efi-updatevar.c b/efi-updatevar.c
index 4247105..033d938 100644
--- a/efi-updatevar.c
+++ b/efi-updatevar.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <strings.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <unistd.h>

Related to:

  <https://fedoraproject.org/wiki/Changes/PortingToModernC>
  <https://fedoraproject.org/wiki/Toolchain/PortingToModernC>

