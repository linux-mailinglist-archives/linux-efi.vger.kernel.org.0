Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F84FFCFA
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiDMRlK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiDMRlH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 13:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E39B6C973
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 10:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2773961EEF
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 17:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9EAC385A3
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871524;
        bh=gtUkGYq1IimTkF0/YY4TakXdA5Zd5rQvfl03j5cJDj4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K3XG/tEJ+aSOthPD4m/R9tiqXwQWnHtEGqa0E0s4ey2WhRqEFxk1xi/l+qenRKd48
         1K95fXieHekFrLsmVB6DkRgc3qpG1Tl+LxmfORgNQNAV5Vl8SIHxzrFqiC8kdlImQn
         OP6xV8SeS/IOZXJ6dFBVHQbP8M2M6nbU6LT3apyC0lZl3QUJgwjWZ7kp9v/PYldufL
         NKWlMcMWSRbdxGtbTZklrO4tf+eK4SkAd9xjpgJLaqf8WovZutbaHoCtFNvBNipbqe
         E9YqxCTHPtTf4QDwQOOl0UnDyIRjlzZlJikTyKEq0r8js/qi+qeL/Cktrww26sLKjn
         SZW1gTNLIsIKw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-de3eda6b5dso2788382fac.0
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 10:38:44 -0700 (PDT)
X-Gm-Message-State: AOAM533Ei+BzYfzH/RbNKWFiqKCyGdeWsZnz2goRER1gTVPt/IXqBmT1
        ktM6b3qaJSgQfPpkWzkQdQ5sCH4C6vFP1yn9Jw0=
X-Google-Smtp-Source: ABdhPJwM5ukrbn1jgSwYyMXRuZUXodi/Zy+in6S6dZa3FcS0BZ19trGtwWLaNd1KhmHU9rfQ/qJraJdCytYslpqkeVc=
X-Received: by 2002:a05:6870:b027:b0:de:7fcd:fabf with SMTP id
 y39-20020a056870b02700b000de7fcdfabfmr16647oae.126.1649871523675; Wed, 13 Apr
 2022 10:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRPHE+Jn4UAV3THuK6nwF4G0R5LxT2EhQndTUqw8fOPMjWZPw@mail.gmail.com>
In-Reply-To: <CAGRPHE+Jn4UAV3THuK6nwF4G0R5LxT2EhQndTUqw8fOPMjWZPw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:38:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFf=AXQ1YKacXijX98fo5dQBsEEy0dOQ-21gXo9NC89CA@mail.gmail.com>
Message-ID: <CAMj1kXFf=AXQ1YKacXijX98fo5dQBsEEy0dOQ-21gXo9NC89CA@mail.gmail.com>
Subject: Re: Increasing EFI_MMAP_NR_SLACK_SLOTS
To:     =?UTF-8?Q?V=C3=ADctor_Gonzalo?= <victor.gonzalo@anddroptable.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 3 Sept 2021 at 00:26, V=C3=ADctor Gonzalo
<victor.gonzalo@anddroptable.net> wrote:
>
> Hello
>
> I had an issue in a big server in which no linux distro I tried was
> able to boot. It failed with the messages:
>
> EFI stub: ERROR: exit_boot() failed!
> EFI stub: ERROR: efi_main() failed!
>
> Digging through the rabbit hole I reached the error in the call to
> efi_bs_call(get_memory_map) inside efi_exit_boot_services() in
> efi-stub-helper.c which returned EFI_BUFFER_TOO_SMALL, so everything
> collapsed after that.
>
> It looks like despite what the comment suggests, the headroom was not eno=
ugh.
> I fixed it by increasing the value of EFI_MMAP_NR_SLACK_SLOTS to 16.
>
> Is this the right approach to fix the issue?
> Would it be ok to change the value in the mainline?
>

I don't think changing that would be a problem. Patches welcome.
