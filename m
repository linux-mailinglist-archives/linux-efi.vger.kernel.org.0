Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A76341A3
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiKVQiR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiKVQiQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:38:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488CD2C4;
        Tue, 22 Nov 2022 08:38:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F80021EE0;
        Tue, 22 Nov 2022 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669135094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2HaFudDaMDVTnrq9g6vTYOKijFH6XNF8q+9ygX8nBYA=;
        b=fakECqQAM0jXiY64Wp3MlDxQ0wrI17FsjJs9aBXR4mPgmulrLathoVy4tvMr6JxJ+MqkMI
        qZ1FWS9pVQJr8Bc6fK6I/LZSTDe6x3x1PB3wTv72Scma9KVfatS2oZDDQ+P+n6sZua5thx
        lBeotURNkC+lOLawZpZRsFK3RlSaTq0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEFFB13AA1;
        Tue, 22 Nov 2022 16:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K5PhOPX6fGMNPgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 22 Nov 2022 16:38:13 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 0/3] x86/realmode: use a dummy trampoline for Xen PV guests
Date:   Tue, 22 Nov 2022 17:38:07 +0100
Message-Id: <20221122163810.29752-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A Xen PV guests can't run in realmode, so the realmode trampoline can
omitted.

Changes in V2:
- complete new approach

Juergen Gross (3):
  x86/realmode: test real_mode_header outside of real_mode_size_needed()
  x86/realmode: add trampoline reference structure
  x86/xen: add a dummy trampoline for Xen PV guests

 arch/x86/include/asm/realmode.h | 15 +++++++++++----
 arch/x86/platform/efi/quirks.c  |  3 ++-
 arch/x86/realmode/init.c        | 25 ++++++++++++++++++++-----
 arch/x86/xen/enlighten_pv.c     | 17 +++++++++++++++++
 4 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.35.3

