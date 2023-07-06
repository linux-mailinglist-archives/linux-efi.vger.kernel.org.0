Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABC0749AC4
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jul 2023 13:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGFLg2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jul 2023 07:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGFLg1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jul 2023 07:36:27 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8E0AA;
        Thu,  6 Jul 2023 04:36:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6973E5C00CF;
        Thu,  6 Jul 2023 07:36:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Jul 2023 07:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688643386; x=1688729786; bh=C6
        FVmoTeWIWnJ398pRC/XE6TyNj7Ymf62dAsmaGtmb0=; b=BGdluiom3ggcRnDdxp
        oee0FvzfxpIvCY638tQFktcGhwOwhI/XrlJsyp2RiY/jp66a0kp0i4kzB50Nqzj+
        m/GNGAiPe1F+41dKNx0j9TXocBWXc2ufXklfxDDTcKLAr8QK90fpbFQYooSOvxNY
        squbxC2U9VEEYoab/tsz66VHwP4qpRaAybj3RyetmVcABnDy35/H4PhNI537HMMl
        Alp905FYz+MUPF+uTBorshIxPxn5GXogQUBG7RsNU+9iKDeCBgTAeOPPsIdsHR+A
        iqE5oUzoC6eNOhKT+ggsZELNRm9QR+bdKDO4Z1RA640NTcaNlR2u6h+PPS/STnPy
        6fvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688643386; x=1688729786; bh=C6FVmoTeWIWnJ
        398pRC/XE6TyNj7Ymf62dAsmaGtmb0=; b=HgJL/+GrbgeA+YFm5wY12KsV+XMlf
        I27AR7t2G64hgj9h3LHJ9JHL/p0fuYvHGoBUFQmnExZEw15FQu3X5vrkOiZITQfT
        aAR4LFGeGQWIFunHDDZSbhA/B79sOx1cKVUBvih/BhOyCK0kKIW1E+lKx03BWFK+
        9hHhJrL2sNGDfTWAuQIO8zbQkPeKCZmCNsmUCEz9HHfVM9gOkUMVo8hf+hS0kFxx
        Kxo7Nt2rTl+DdncvRl3sbXo18vOFay3Y9mwGu8/xBannx8AdWSuUTc6aikJwg8oY
        UtMXxykZEzyYo1vLbYLvGIemQHhNvC9ILdHpvLo72fsANwPNPbyi9birw==
X-ME-Sender: <xms:OaemZOVlx0154p7bocZZlUeBHpdW82c0XY_NdXki0MG0Ou92E5XCjg>
    <xme:OaemZKk8hBBmwpHJ3NcYpX4zrZ9G4zOa33jY7F_gmcq-MWcaY1DeaKYxVIJVkEIns
    rNPrzavq1Io0MH0aFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OaemZCYC-kcNVGyv9tbkCRAZgzbXAnZNjIdYX4lmWN2MRrQEyK-GoQ>
    <xmx:OaemZFV6THc4JH7aD5rBuPCk8TpjQpy6zynjY4ckYHEcPWFLG86o2A>
    <xmx:OaemZIk4GDpiUC1IRM-thG41fdAQ8w_42nIr51vo8Fq_AXoedROxQg>
    <xmx:OqemZBf_EX86cWlRl9fbPwVaJYQVWvnoMpDF7tXummLoJFIh-O-IMg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8E56CB60089; Thu,  6 Jul 2023 07:36:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <97ae7c3d-3eeb-4bd5-bac3-64a1605d48e2@app.fastmail.com>
In-Reply-To: <20230706104852.27451-3-tzimmermann@suse.de>
References: <20230706104852.27451-1-tzimmermann@suse.de>
 <20230706104852.27451-3-tzimmermann@suse.de>
Date:   Thu, 06 Jul 2023 13:36:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Sui Jingfeng" <suijingfeng@loongson.cn>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>,
        "Teddy Wang" <teddy.wang@siliconmotion.com>,
        "Helge Deller" <deller@gmx.de>
Subject: Re: [PATCH v2 2/4] fbdev/sm712fb: Do not include <linux/screen_info.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 6, 2023, at 12:42, Thomas Zimmermann wrote:
> Sm712fb's dependency on <linux/screen_info.h> is artificial in that
> it only uses struct screen_info for its internals. Replace the use of
> struct screen_info with a custom data structure and remove the include
> of <linux/screen_info.h>.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Helge Deller <deller@gmx.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
