Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800D775362C
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jul 2023 11:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjGNJNR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jul 2023 05:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjGNJNR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jul 2023 05:13:17 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3D6E65;
        Fri, 14 Jul 2023 02:13:13 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 0C4D0424A2; Fri, 14 Jul 2023 10:13:10 +0100 (BST)
Date:   Fri, 14 Jul 2023 10:13:10 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Luca Boccassi <bluca@debian.org>, Peter Jones <pjones@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <20230714091310.GA21128@srcf.ucam.org>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home>
 <CAMw=ZnSF_s-+74gURPpXCU+YSTeXDAYfVp_A9DOFoW7oL2T_Hw@mail.gmail.com>
 <CAMj1kXG1Sk1G=3PCRmiHZ24qPdUYiGRkSbq57u1-KUbyorX8Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG1Sk1G=3PCRmiHZ24qPdUYiGRkSbq57u1-KUbyorX8Lg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 14, 2023 at 10:52:20AM +0200, Ard Biesheuvel wrote:

> Maybe the OEMs have gotten better at this over the years, but it is
> definitely not possible for the distros to rely on being able to get
> their own cert into KEK and sign their builds directly.

Getting certs into local machine databases should[1] be possible on all 
Windows certified machines, but in the status-quo there's no 
cross-vendor solution to doing this. Relying on the Shim-provided 
mechanisms is much safer from a consistency perspective.

[1] Every time someone has claimed it's impossible to me I've ended up 
demonstrating otherwise, but that's not a guarantee
