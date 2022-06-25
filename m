Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D968555AB75
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jun 2022 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiFYQBv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jun 2022 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiFYQBv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Jun 2022 12:01:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D915A2A;
        Sat, 25 Jun 2022 09:01:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B38ED614FB;
        Sat, 25 Jun 2022 16:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA262C3411C;
        Sat, 25 Jun 2022 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656172908;
        bh=P3GsmeThlxmqDDdq7R03/BK/ND7CKY2z2N/15Usv7Lg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ajhzmGjAMwuwcFkWretu1EACoUZpnSvor6yMJSys/jzpVeAQqFc6NV8q1W8rtIh2l
         41aaN/A6+hzBluhHLvJHUfD5rU3OgQuhkDqQcrsKRP4eAYP0yuDlxvqrnomYaLBhAa
         DZE6MqF1XBEUn4+MvdsoDAOpxdzobIirLBDk/4RmZvT9a/Kn9Sw/dMNpokZ6zhBDyI
         EDdoYKQwdXmj9vWXYqgTS23ggpz5uzlRPthm5cdeWuZx5w6cU2Gbb2+qOUsuL6BBui
         M26vzO886o/0ai/sosVIasFK/vAwv6JmxN6fcE9dJlH7prgIVXEOWHqGiGm0DxtU6b
         onZfelp0Fh/ZQ==
Received: by mail-oi1-f180.google.com with SMTP id s124so7455517oia.0;
        Sat, 25 Jun 2022 09:01:48 -0700 (PDT)
X-Gm-Message-State: AJIora+MBZVpgdrGJV+5UUXrP/7aRhmpbG1zHivgKF57aVLZsbgZzOBZ
        nCSoIc7jDkMbwND+KUoMiDa1e4qDfTfryAzokG4=
X-Google-Smtp-Source: AGRyM1uaCHY8Lb3HoMmR8FXrGTi6khWzu6IOICO4hwYBBDxF7teFrFP6XD97v3ogLiRq4VNhJA+E4lqQDnfPpm4fFLY=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr2869227oib.126.1656172907994; Sat, 25
 Jun 2022 09:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220624152331.4009502-1-sudeep.holla@arm.com>
 <20220624152331.4009502-2-sudeep.holla@arm.com> <CAMj1kXFAwzttyi=--fJyh9bGXv30Z4dkVR02_taS3JtKJXsLhA@mail.gmail.com>
 <20220625101029.qekxekisalya2iys@bogus>
In-Reply-To: <20220625101029.qekxekisalya2iys@bogus>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 25 Jun 2022 18:01:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFRqCv1AoXO8CoVXo2KJ=xhRzEYaA8sjGV3PKPZk9y9xw@mail.gmail.com>
Message-ID: <CAMj1kXFRqCv1AoXO8CoVXo2KJ=xhRzEYaA8sjGV3PKPZk9y9xw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: efi: Simplify arch_efi_call_virt macro by not
 using efi_##f##_t type
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 25 Jun 2022 at 12:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Jun 24, 2022 at 07:45:14PM +0200, Ard Biesheuvel wrote:
> > On Fri, 24 Jun 2022 at 17:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Currently, the arch_efi_call_virt() assumes all users of it will have
> > > defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> > > forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> > > actually expects void pointer.
> > >
> > > Simplify the arch_efi_call_virt() macro by typecasting p->f to (void *)
> > > as required by __efi_rt_asm_wrapper() and eliminate the explicit need
> > > for efi_##f##_t type for every user of this macro.
> > >
> >
> > Can't we just use typeof() here?
>
> I had tried that, but unless p->f is pointer of some type, we will get
> the warning as it is passed without a cast to __efi_rt_asm_wrapper().
>
> > __efi_rt_asm_wrapper() was intended as a temporary thing, so I'd
> > prefer to avoid starting to rely on the void* type of its first
> > argument.
> >
>
> Fair enough. Can we expect p->f to be some pointer then ? If yes, then
> PRMT driver needs to change the handler_addr from u64 to some pointer
> which sounds OK to me.
>

We are dealing with function pointers here, so passing those as u64 is
just sloppy.
