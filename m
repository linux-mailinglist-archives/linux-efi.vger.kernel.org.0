Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28E055A8BB
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jun 2022 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiFYKLp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jun 2022 06:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiFYKLo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Jun 2022 06:11:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20429175A9;
        Sat, 25 Jun 2022 03:11:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC5D123A;
        Sat, 25 Jun 2022 03:11:42 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 614DD3F66F;
        Sat, 25 Jun 2022 03:11:40 -0700 (PDT)
Date:   Sat, 25 Jun 2022 11:10:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Subject: Re: [PATCH 1/3] arm64: efi: Simplify arch_efi_call_virt macro by not
 using efi_##f##_t type
Message-ID: <20220625101029.qekxekisalya2iys@bogus>
References: <20220624152331.4009502-1-sudeep.holla@arm.com>
 <20220624152331.4009502-2-sudeep.holla@arm.com>
 <CAMj1kXFAwzttyi=--fJyh9bGXv30Z4dkVR02_taS3JtKJXsLhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFAwzttyi=--fJyh9bGXv30Z4dkVR02_taS3JtKJXsLhA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 07:45:14PM +0200, Ard Biesheuvel wrote:
> On Fri, 24 Jun 2022 at 17:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Currently, the arch_efi_call_virt() assumes all users of it will have
> > defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> > forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> > actually expects void pointer.
> >
> > Simplify the arch_efi_call_virt() macro by typecasting p->f to (void *)
> > as required by __efi_rt_asm_wrapper() and eliminate the explicit need
> > for efi_##f##_t type for every user of this macro.
> >
>
> Can't we just use typeof() here?

I had tried that, but unless p->f is pointer of some type, we will get
the warning as it is passed without a cast to __efi_rt_asm_wrapper().

> __efi_rt_asm_wrapper() was intended as a temporary thing, so I'd
> prefer to avoid starting to rely on the void* type of its first
> argument.
>

Fair enough. Can we expect p->f to be some pointer then ? If yes, then
PRMT driver needs to change the handler_addr from u64 to some pointer
which sounds OK to me.

--
Regards,
Sudeep
