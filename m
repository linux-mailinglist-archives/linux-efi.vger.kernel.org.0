Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0255362F
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351988AbiFUPgi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351828AbiFUPgh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 11:36:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4382A734;
        Tue, 21 Jun 2022 08:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13887B81A66;
        Tue, 21 Jun 2022 15:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9598DC341C4;
        Tue, 21 Jun 2022 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655825793;
        bh=X2IZFlLDvw59kZUFryr/lUy43KEq5hsgawhWP8FvINg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P10HG9L0/T9LAo78BphskNiMkrHuo7iI3bghciUrQDK2jBnrEOi0vXewvdLMP1btx
         zdtcaFj6fJneAj/AFMiRMPxgfhxmAnrwU5B3bimRn7yiL5gkF/QJ/kcunqdXK12r+v
         7E+J84bxEQ8zQu6EDezLX+DPaIQB8D6d2TZOVxa064TsP9U5oU55HSZPg+Nt+dwtxk
         CkbUM4kb6NjIrWc4uvWYCs0hwhe4kndy5Qo9AjWTSJS2badLP5EMEO03d4uB6tmVNP
         Vy2x4nWFuZjw3TPYKtmwRn08QgVHiOerSfdi8OhF36sP6rYjAZRuzHYJG5XAnGL8tQ
         pMFUBLGytssDA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 1/9] pstore: Don't expose ECC metadata via pstore file system
Date:   Tue, 21 Jun 2022 17:36:15 +0200
Message-Id: <20220621153623.3786960-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621153623.3786960-1-ardb@kernel.org>
References: <20220621153623.3786960-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; h=from:subject; bh=X2IZFlLDvw59kZUFryr/lUy43KEq5hsgawhWP8FvINg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiseVoBHC+OBzHPWUPR/ztj2U0FqsWxo3CWG0Z00Wi QVp3Kn+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHlaAAKCRDDTyI5ktmPJK3oDA CDuLO9c6Smjkix3WjVMSmmYIjOgvpmK+lYDBeKeLXn+CLjHcPx+KdHrzDrjgVqNqGoSIJw+VB98Rtl lS15bi7pWLCYei2wuSA3wklxaCKr2JDGJSY1Fa2GzYhVowkmcQ1FU453NOB3zOlPKFHBFJZECmY/kj LiiG/Mjh4xY5hm/m161294bUBm8P9YbdbqtnJ1LOrCnj2B8RgERfwjcFCYjdSy8fNpQEPVbZNEk//l NlifN9NyurezGYkmxGz5qEXZugynBgPvEBkynfYyTKUbJE0YeKSbn6B9nvfvv+kNb1mAy4UzKoJnCq Vnt3pZS559ftd0X9ycQYRNYFve+mSGb0TvlNmkoLmQtaa698p4S0gH8DlS/mmJgrG8H7hjrFG3wGji kzatr2Q+gTHdpL63E/4mlrVOiodklPJpjvLcyVOEJTRwdVsAG9uvh8eUxXZum5lnrcxV2e8fez9V7N EyoiJmVsB3XlBL4kN97sWGnVnUvF9fkBa3SCCMfIAUzVQ=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If a pstore record has its ecc_notice_size field set to >0, it means the
record's buffer has that many additional bytes appended to the end that
carry backend specific metadata, typically used for error correction.

Given that this is backend specific, and that user space cannot really
make sense of this metadata anyway, let's not expose it via the pstore
filesystem.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/pstore/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 14658b009f1b..b62eead3f801 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -349,7 +349,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	int			rc = 0;
 	char			name[PSTORE_NAMELEN];
 	struct pstore_private	*private, *pos;
-	size_t			size = record->size + record->ecc_notice_size;
+	size_t			size = record->size;
 
 	if (WARN_ON(!inode_is_locked(d_inode(root))))
 		return -EINVAL;
-- 
2.35.1

