Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6A4C780B
	for <lists+linux-efi@lfdr.de>; Mon, 28 Feb 2022 19:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbiB1SkT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Feb 2022 13:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiB1SkK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Feb 2022 13:40:10 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC69A9A7E;
        Mon, 28 Feb 2022 10:30:46 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id A0CAC40A62; Mon, 28 Feb 2022 18:30:44 +0000 (GMT)
Date:   Mon, 28 Feb 2022 18:30:44 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>, Peter Jones <pjones@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 0/2] Handle UEFI NX-restricted page tables
Message-ID: <20220228183044.GA18400@srcf.ucam.org>
References: <20220224154330.26564-1-baskov@ispras.ru>
 <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGg=HAv3P_NKqUHCg6bRFsB0qhfa_z-TOdmi-G8EqPrZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 28, 2022 at 05:45:53PM +0100, Ard Biesheuvel wrote:

> Given that this is a workaround for a very specific issue arising on
> PI based implementations of UEFI, I consider this a quirk, and so I
> think this approach is reasonable. I'd still like to gate it on some
> kind of identification, though - perhaps something related to DMI like
> the x86 core kernel does as well.

When the V1 patches were reviewed, you suggested allocating 
EFI_LOADER_CODE rather than EFI_LOADER_DATA. The example given for a 
failure case is when NxMemoryProtectionPolicy is set to 0x7fd4, in which 
case EFI_LOADER_CODE, EFI_BOOT_SERVICES_CODE and 
EFI_RUNTIEM_SERVICES_CODE should not have the nx policy applied. So it 
seems like your initial suggestion (s/LOADER_DATA/LOADER_CODE/) should 
have worked, even if there was disagreement about whether the spec 
required it to. Is this firmware applying a stricter policy?
