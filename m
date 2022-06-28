Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189A555EA24
	for <lists+linux-efi@lfdr.de>; Tue, 28 Jun 2022 18:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiF1Qvs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Jun 2022 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347917AbiF1QuJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Jun 2022 12:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21314E7
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 09:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9846061881
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 16:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D61C341C8
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656434990;
        bh=ku/jA51MZ2NjXYjUHHRFgql7I6SkEsy6p/iWB2NdSJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QO0CKsUQz2LmZEhJ5bz+oHfdG1674yO1ZtmpHVpN9btYtrB4lA0Hvfy6JDh6o4CGX
         0lXtDUc2qtwXt//EWR+IdmlUf3DA64C+E19QIaTN1dqnUs0DOYa/aiM05UQ4hYkvS3
         AoEujscnEtflv3I3/5Bw+qpFqo15ZDbHC9rafoXMF2bTTIsErevuJXZSS8M+2nHdWz
         GGsmMtHb5uCPPHxvZMzpQBsVe4FQZAORcn+/CwSGlOb9yRUZTH50OVE7LZIo7odIti
         JnatO/+LXcTb3rVfAw2bF5u5aQfGkUmbEz9RW4+lcPmpZDIJ/ggPcziOcXWCpsuolH
         TORFZou8r0oOw==
Received: by mail-oi1-f169.google.com with SMTP id w83so17996657oiw.1
        for <linux-efi@vger.kernel.org>; Tue, 28 Jun 2022 09:49:48 -0700 (PDT)
X-Gm-Message-State: AJIora9xDtPXSzkWBmWo+l7zoQuknbt+ikNRUJ9EepunolW2Rpeu5ttH
        uVTamPC760ABwg1ywLj+OAhOMQlkCI9tbKKZMm4=
X-Google-Smtp-Source: AGRyM1v8+PQZX1U944MISOO5QheFv53TGYmxen3lfxSrasG7kr5oMzaz+U6YYfdJXALql/rC7olLdFccwnIRAmmRIpU=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr359151oib.126.1656434988198; Tue, 28
 Jun 2022 09:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220628141821.849643-1-sudeep.holla@arm.com> <CAMj1kXHyMNn5bZceb4QnnQfBJ3bWpM5PLdZXR4ECGhmT7hzVbA@mail.gmail.com>
 <YrswQH7fsQpEtEK5@shell.armlinux.org.uk>
In-Reply-To: <YrswQH7fsQpEtEK5@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Jun 2022 18:49:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE24JizpwzT1P+2NmEeLZLhKp2MJz+z4kCYP4xvVuJAtg@mail.gmail.com>
Message-ID: <CAMj1kXE24JizpwzT1P+2NmEeLZLhKp2MJz+z4kCYP4xvVuJAtg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: efi: Simplify arch_efi_call_virt() macro
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Jun 2022 at 18:45, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jun 28, 2022 at 06:29:52PM +0200, Ard Biesheuvel wrote:
> > On Tue, 28 Jun 2022 at 16:18, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > Currently, the arch_efi_call_virt() assumes all users of it will have
> > > defined a type 'efi_##f##_t' to make use of it. It is unnecessarily
> > > forcing the users to create a new typedef when __efi_rt_asm_wrapper()
> > > actually expects void pointer.
> > >
> > > Simplify the arch_efi_call_virt() macro by eliminating the explicit
> > > need for efi_##f##_t type for every user of this macro.
> > >
> > > This change is done to align with implementations on other similar
> > > architectures.
> > >
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > I'll queue this one up right away in the EFI tree, unless Russell has
> > something else in mind?
>
> No, looks good, thanks.
>
> Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>

OK, thanks - queued in efi/next.
