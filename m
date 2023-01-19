Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5367422E
	for <lists+linux-efi@lfdr.de>; Thu, 19 Jan 2023 20:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjASTG2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 14:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjASTGB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 14:06:01 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917D29AA9B;
        Thu, 19 Jan 2023 11:05:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CAD05C0164;
        Thu, 19 Jan 2023 14:04:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 19 Jan 2023 14:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1674155050; x=1674241450; bh=DWSmhiY53c1fCxHo8+QDF152rmPtSJZJfbo
        sjDMfwaA=; b=mIINDxvzEWW1TOvsfQmK1217TTk1+rcauO+ev2im7SruFDL9Z+x
        I55qi7LfuGXU580EJe6mvU4RT7u0J3pg94ZMtAuJIISKsDjBgGYHm/1qUR0H4mpD
        WM4Jwzgadwn5ZNCtd7cLSP4GryJwgDS5tcqiZ2WuF0VFHlEmP0H12XXwgw/bA2VM
        D+ORqlOnF1PXQlBxQpvla9356m5aUhMW3cuir7ViyU9szXwO4+XtoqBT5aEiz5Z7
        ql0MnXUoqLcmdaq7T/SdfozkryrUH03Gdwqm8AVPB3xW7HVRnQ1y36b9h4dUJvWi
        8I5N/bGK0y223R25ysBur+t/EufqWCdd5Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674155050; x=1674241450; bh=DWSmhiY53c1fC
        xHo8+QDF152rmPtSJZJfbosjDMfwaA=; b=UoYj+qtsnWGUKKUdT4zCotFPuyjZs
        ve1NZ2BaZwMeJ+xH9VClymTkxYMPmU8X6ky3uNjs14U7UyKqCuY0gNGW2nslmRFU
        JUOc0SzGRsxNmQZaJICDHvnanyJeSIJyq4qJkHvlVH3rsKnzOV1ip8oWbCSaK/G8
        ZY9p2YKLdoisEOPKoIY3YBttNmwp4onjcG0Dc/YQgOE8g5iwuzNH4KQRhZ8Ndq46
        AQQxtVI952u5yMcNOzkWIpTc5U6zwE7GrpHabea+8R2Jb14xo/lgRPS8yRNckDYK
        xqsdEcZAaBe7PJvXkRN6eOLjM/CMAUiJKFHP4rsN0Aq6KfFvwaO0XFURQ==
X-ME-Sender: <xms:KZTJY5kxRBbHsi58SSGXG0thzHypBrE0ywzVyRgSh8rhyiH1g3VK-Q>
    <xme:KZTJY02wmm7OwC6JqVT4x2pEI4Ek4GZ_RtIfkFVT9Ul4nJWPrkyIHH2DV1qStLBgB
    vFQ4VZUBhJmX9k>
X-ME-Received: <xmr:KZTJY_qWnlZnCAO0qq42vjpQRJ6z44snfew9zof9wJiNHQBaEyRhIAAcj6RftpriZbTjj9YNVRJD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:KZTJY5lQhpx0TLu1FIedmKRxrwKBKNsirPTu2rgwc81AdXdowggaqg>
    <xmx:KZTJY32L6Yg4VlAjM-EBSUH6sB3f_BMV-kTrynK3dmsKf0fx3Dgh9Q>
    <xmx:KZTJY4tO5ZxrmnCj9Or9SivEJ5tQP29NyVj_9NIaj9B3vSUHZDyRhg>
    <xmx:KpTJYxovdbTDQlMID3b5Xe01VE9uVnvHDQo-ibZJhp2YeqNeyiGVzQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 14:04:09 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v3 0/5] efi: Support ESRT under Xen
Date:   Thu, 19 Jan 2023 14:03:55 -0500
Message-Id: <b18879e0329c785d35f2aa2164413bb56419c684.1674153153.git.demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20221003112625.972646-1-ardb@kernel.org>
References: <20221003112625.972646-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch series fixes handling of EFI tables when running under Xen.
These fixes allow the ESRT to be loaded when running paravirtualized in
dom0, making the use of EFI capsule updates possible.

Demi Marie Obenour (5):
  efi: memmap: Disregard bogus entries instead of returning them
  efi: xen: Implement memory descriptor lookup based on hypercall
  efi: Apply allowlist to EFI configuration tables when running under
    Xen
  efi: Actually enable the ESRT under Xen
  efi: Warn if trying to reserve memory under Xen

 drivers/firmware/efi/efi.c  | 22 ++++++++++++-
 drivers/firmware/efi/esrt.c | 15 +++------
 drivers/xen/efi.c           | 61 +++++++++++++++++++++++++++++++++++++
 include/linux/efi.h         |  3 ++
 4 files changed, 90 insertions(+), 11 deletions(-)

-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
