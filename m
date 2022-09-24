Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709845E8694
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 02:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiIXALf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 20:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiIXALO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 20:11:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3772EE9;
        Fri, 23 Sep 2022 17:10:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A7DB85C0170;
        Fri, 23 Sep 2022 20:09:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 23 Sep 2022 20:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1663978199; x=1664064599; bh=Hp
        TSgc+JtI8EhcgDnRflTiihumyKPmyMtcl3Vev12iA=; b=rS4R+WXuTO+Kafxtzh
        SPi+RBCSmNOAVc+iLcPD19o2ra75YNTauLySX6rTdrgoAGKIYqLcGWs8doDfdyri
        43XlkUXRsMDK26ERip5OxEfsFtjUCoz9wlwSFOCWVWyrXeDB9vxY76kO9FvZXX0q
        B+AaSmKaudLlP1eZ+UNIvibHQf/+Eu+nORjSFokzdZ33LV5xqNDXZTnnKF43xYOJ
        nx13wiJLwGfu0VrliDbuGU1Xj0Ju6Zu39aIjufUqs7Ay1r5xbAN6jLSplvrU8bvg
        XgqQ4+kSPNPGIs9C8zL5eg1SPjqOZn7na/b4L+/jyZCM6iPBXHMG40VYDR9Lu0aP
        M8pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663978199; x=1664064599; bh=HpTSgc+JtI8EhcgDnRflTiihumyK
        PmyMtcl3Vev12iA=; b=cHAdZp7/26aEGi5SUc4ERL/Y7B5+Jp98xq+qn3A7750Y
        tjm6dkH6/YOIiVde6hIEpSQUUbju64I/JoSzqz87uPRBH9m4UygfI7uBBY+sswuU
        Vpw2T7FE7xHpdebXQw062UA7v2J1J33t4MtfCup5SX4REEaaFKEDqfni036mZVrs
        hEBJm6Sqs29UQJHErD7rHgPnpCmDALD/OPkj8/tAEX07hqf/uQPvUVRIZN/3GtOD
        n/fAPZyiB9zbn98wfnyQ/Yp65TuS4jg2DCShMVpVuA/fsrxTl4JBf79CqUin3AMH
        3mtYAXuAjiOZZcMrRMMs95XtfwIPzACE/waMtIayQA==
X-ME-Sender: <xms:1kouYyST4lgEdnSPAnAlaDRV0ITpCctBXDTyK2pDwIPV6rmKfeSciQ>
    <xme:1kouY3wa0Y0nRTHMmtL4GC7dIKJiHV3HvpmnKJaiy2AmsjNskKbcrEP6cUjKTuRwc
    makWecjfyM0FdFRhtY>
X-ME-Received: <xmr:1kouY_0GhCmlBiCZ02_GZPKt4d29Btk88unmDkT2VEN3Q_2ayM8j8TtBNDNiLILgkDS-4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:1kouY-CznWfF7f7R-2vkc68QcJB5Htq__FmvPkSMlMDCFt3QfvwTYg>
    <xmx:1kouY7iahBxjFS1SVvVhEDONwBsj2H01fupMPCncYuKtrFI_ZSefcQ>
    <xmx:1kouY6rM_fl8z6B9Lro_aNp2ueePdPMWa_mW3KYMAHlNxNBgkF9ZQA>
    <xmx:10ouY-pdqDBtQgdmQuewVDUeDT9hGqS0FKitm-eaqEP9OEdW_hPgkA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Sep 2022 20:09:58 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B4633104B3D; Sat, 24 Sep 2022 03:09:54 +0300 (+03)
Date:   Sat, 24 Sep 2022 03:09:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/mm: Disable W^X detection and enforcement on 32-bit
Message-ID: <20220924000954.hhaghgkrb6h33nvq@box.shutemov.name>
References: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 23, 2022 at 03:17:30PM -0700, Dave Hansen wrote:
> The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
> even have NX support.  Even PAE builds that support NX have to contend
> with things like EFI data and code mixed in the same pages where W+X
> is unavoidable.
> 
> The folks still running X86_32=y kernels are unlikely to care much about
> NX.  That combined with the fundamental inability fix _all_ of the W+X
> things means this code had little value on X86_32=y.  Disable the checks.

Maybe downgrade the check to a warning for X86_32=y?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
