Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF015BCA0
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 11:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgBMKVL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 05:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKVL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 05:21:11 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08AAC217F4;
        Thu, 13 Feb 2020 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581589270;
        bh=Kyl8I1DFqEKINSEj7nz5tEXZ5ssSBEs7mkX+qP/eNKg=;
        h=From:To:Cc:Subject:Date:From;
        b=ivSIR+QRZBwcdxwxZOl2Bq7e6z64WpepSQmFSCShK1DeBeoMT2XZWy5WatUxmDS54
         pOB/JgxMaT6Esl00QCBZ5VbSpBQpRLnJ+9jkc717OdmHjSVqUov3DwQocUKWRsemjD
         Z85oin0naN9DQKpNMzl+NoQoE+qxZPewIOtF/1nc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 0/3] efi/x86: Some mixed mode fixes
Date:   Thu, 13 Feb 2020 11:20:59 +0100
Message-Id: <20200213102102.30170-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hans reports that v5.6-rc1 triggers a WARN() when booting in mixed mode,
which appears to be due to the fact that a GUID argument allocated on
the vmap'ed stack and passed by reference to the EFI runtime services
is no longer aligned to its size, which is what the mixed mode runtime
wrappers expect.

Let's fix this in a way that doesn't burden the caller, and copy the
GUID into a suitably aligned buffer in the runtime wrappers. (#1)

Then, patches #2 and #3 are additional cleanup and correctness fixes
for the mixed mode runtime wrappers.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Andy Lutomirski <luto@amacapital.net>

Ard Biesheuvel (3):
  efi/x86: align GUIDs to their size in the mixed mode runtime wrapper
  efi/x86: remove support for EFI time and counter services in mixed
    mode
  efi/x86: Handle by-ref arguments covering multiple pages in mixed mode

 arch/x86/platform/efi/efi_64.c | 151 +++++++-------------
 1 file changed, 52 insertions(+), 99 deletions(-)

-- 
2.17.1

