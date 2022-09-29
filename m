Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCC5F0124
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiI2XCn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 29 Sep 2022 19:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiI2XCm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 29 Sep 2022 19:02:42 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0926312BDA8;
        Thu, 29 Sep 2022 16:02:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D5E35C00CD;
        Thu, 29 Sep 2022 19:02:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 29 Sep 2022 19:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1664492558; x=
        1664578958; bh=IK4PrtYlt6FvEILgVx+LXMjgInjbFPmYscTeYJuAF2k=; b=B
        9FYF+x8IemmpwNug/0+PvLzlGj142TfSnr3GFIaTbQEEBVeAGSiXBQsyJCUBywQ6
        DA1gf7WDSj5bCP1VwD7f1C9nrK3zoVs0t17lcksaa2NuzFjRAcRzlczrQ+e0bZKx
        SJZJbtH5X7oOnM7AXIsCuSsR7s0KQKKjHC7xJSHO95HN+kBUvPpa4p8Vtp4ZIqW2
        iQRQrP/Hz5aaTUyDUx5wd1HJUT5KkbfUEezbRAtxScWhUFux1j+JJsD/RLFJnpY3
        yt3EHXZuQXGJl8XImdkwRDa8AfNsOi8jxGfxiqrUBuM21w2CEtzrbZUs7xoD2eIu
        BU5pvDRNCENa+/RHjjMTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1664492558; x=1664578958; bh=IK4PrtYlt6FvEILgVx+LXMjgInjbFPmYscT
        eYJuAF2k=; b=BgAAD495EGOd59wToNbmIlyZc+H5Op0eAmRs3YQq09AIP9WKGj5
        gEzKsOri8EQ/012E7gggifcBkirf7+UN66UYNn944kpkoPNguV9ZPmRwVdGwjkKF
        MPJ2w+s1nzG7ICpKRWeTfVzoDPjfG7kIkgXjZZo4vqLrjvEKMxYWj61HB7snTCw8
        oSxHyUw0WpmPJ/Gj0NtrYGgdMqJR7K6uYwto7UjUaH/zIX2tgnR7al6h/xKbxpKY
        9HHOVuuIgf9M27oekogmgGG96eyJZHoLi5+z9LfIiFIYklR5kLbBylJlXzGREWAX
        fWxM9MkrjRQB2L+TV/ofL0bHEQSCZ9xwFyw==
X-ME-Sender: <xms:DiQ2Y2szkr0j1jfnQG6MjJm-E2FyEDlqT6Woux0L9nrhyrz9pX8pMA>
    <xme:DiQ2Y7ciDIoAfK1Eocy6-_uSbXV3TAjNeVd2vWVkvbSEMq-7P4t5PSHF2_K98yXth
    mNwbe8z5m5UNGQ>
X-ME-Received: <xmr:DiQ2YxyKb1gn9gBNAArZB6Aj3nfPfOJIGdHF9wRlFkIt_P8sBqhSn6iNr3Iqn3O05N1IREoNhOvW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepvdefgeekvdekgfffgeekhfeijedtffek
    hefhleehfeejueetgfelgefgtdevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:DiQ2YxNiRrx_osVDzPjACeme2_vMuFXQQReP4yDMfsl-RlPPNnvGww>
    <xmx:DiQ2Y2-Y3IXzJyy8t-cF6KOlWR1D2zt2Nnuon3Ox4eqSsiblKDgTZw>
    <xmx:DiQ2Y5U9G3nTuh6-7Pk7unzEaKNHcC9pFwl2l9NKafDUPXvLIVAaWQ>
    <xmx:DiQ2Y30k5vjKFkDBsoB54zWTE0jWj30Zly1ml4SE_XjM0zCSmHX_Lw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Sep 2022 19:02:37 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v4 0/2] EFI improvements for Xen dom0
Date:   Thu, 29 Sep 2022 19:02:02 -0400
Message-Id: <cover.1664298147.git.demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.3
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

This fixes EFI table processing in Xen dom0 and adds ESRT support in
that configuration.

Changes since v3:

- Check location of all configuration tables, not just the ESRT.
- Move most Xen-specific code to drivers/xen/.
- Allow configuration tables to be in EFI_ACPI_RECLAIM_MEMORY.

Demi Marie Obenour (2):
  Avoid using EFI tables Xen may have clobbered
  Support ESRT in Xen dom0

 drivers/firmware/efi/efi.c  |  8 ++++---
 drivers/firmware/efi/esrt.c | 43 ++++++++++++++++++++++++++-----------
 drivers/xen/efi.c           | 35 ++++++++++++++++++++++++++++++
 include/linux/efi.h         |  9 ++++++++
 4 files changed, 79 insertions(+), 16 deletions(-)

-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
