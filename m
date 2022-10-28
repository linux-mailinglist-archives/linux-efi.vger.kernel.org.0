Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1B610D75
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ1Jjk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1Jjj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 05:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C81AD2F6
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 02:39:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B64D5626D4
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 09:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF7CC433C1
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666949976;
        bh=aYhUBKjYhUPWZ2mWvGvN4Q7oAnCIsvWSmt/cBfGDjq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sD0rpYq6D8mh/Y9Pt64YKXMuIm3cwaZ4hpuycVqTdmKVk5RzpgBz3f7gcnDTRW1Ps
         y9OtpPjdnuzQbFCS4+hIqtnknpxuTsIfecaPTYYHtf/5vcVRrBT4fd3+L8r4DncyIs
         DZzZ8mIMy2+KX8PtKNr9Bp4dsFaFvsxCWR7TxrQ5KEvcTHLD7PyhaX4VCZ4IMWCy/G
         enu7r6TuK/9V1QPab/A85POVu9rbnK1zi/X4Vg7AtjJNQloNuEpjTCVcr2EIo6sV1y
         b9TDbPTCriBmkakvAo+P6gl+RmdrphsnfYXMg5Pkzsbu5WDTlKG9SW3iW7BkfGAKCZ
         YBsdHKsL/FNqQ==
Received: by mail-lf1-f41.google.com with SMTP id d25so6960330lfb.7
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 02:39:35 -0700 (PDT)
X-Gm-Message-State: ACrzQf3t/BZoeBXGx4DwJPMtSr6VNPJTRMtBpX8G4yTEHp8FSTVuALo5
        HwVT0HwebiRQQOrAs9FQmW+ADAXxs9wp1gXG9Cg=
X-Google-Smtp-Source: AMsMyM7SI3GymxF7wD88PvKAGpqHCYBqLQ5daiy8nnr8g7UI+i8t1qcFlCzDwLsQJNQ0tWZIWVIj3tAsbQk1+On4mBU=
X-Received: by 2002:a05:6512:3119:b0:4a2:d749:ff82 with SMTP id
 n25-20020a056512311900b004a2d749ff82mr20983272lfb.637.1666949974025; Fri, 28
 Oct 2022 02:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <d799b60c-ff4e-44ae-84be-d9ade761ec6d@redhat.com>
 <CAMj1kXHDtwkMgqqwePEKdOdO=7-1_TYyuVNPJ7PkyreaMySjCw@mail.gmail.com> <d469f6b9-d23a-abe6-27b7-f58f9de12a45@redhat.com>
In-Reply-To: <d469f6b9-d23a-abe6-27b7-f58f9de12a45@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Oct 2022 11:39:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUfAE6bGTxTFDQe9HxAZAuAOXenU+GC-39QJfaBOt4tA@mail.gmail.com>
Message-ID: <CAMj1kXFUfAE6bGTxTFDQe9HxAZAuAOXenU+GC-39QJfaBOt4tA@mail.gmail.com>
Subject: Re: [Issue] EFI runtime-wrapper is broken
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 28 Oct 2022 at 11:38, Gavin Shan <gshan@redhat.com> wrote:
>
> Hi Ard,
>
> On 10/28/22 5:21 PM, Ard Biesheuvel wrote:
> > On Fri, 28 Oct 2022 at 11:10, Gavin Shan <gshan@redhat.com> wrote:
> >> I ran into the following crash with v6.1.rc2. I'm not sure if it's known
> >> issue. Last good version is v6.0.rc6/rc7. The kernel configuration is attached.
> >
> > This is probably related to the patch below. It means the firmware is
> > buggy, and does not work as it should if the firmware never calls
> > SetVirtualAddressMap() [and doing so is explicitly described as
> > OPTIONAL by the EFI specification].
> >
> > The problem here is that other EFI implementations (primarily the
> > Qualcomm ones used on Windows-on-ARM laptops) are buggy too, and don't
> > tolerate SetVirtualAddressMap().
> >
> > Can you try whether reverting the patch below helps?
> >
>
> I ran into the issue on server, equipped with Ampere CPUs. With d3549a938b73
> reverted, the crash disappeared.
>

Thanks for confirming

Can you please share the complete boot log and the DMI/SMBIOS data? Thanks.
