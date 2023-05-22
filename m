Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0670B756
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEVILw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjEVILv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 04:11:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC3DAA;
        Mon, 22 May 2023 01:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A306611EC;
        Mon, 22 May 2023 08:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C13C4339B;
        Mon, 22 May 2023 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684743109;
        bh=L2nQr/zNB4k9r1QrqcHzb2skGUGOWpnh00AVGc/I3yc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CF627yfMc0CCIAqqM0itDOkFEuGiz5OJqC5LIpikd8y1748RKNTUbzFCKc7RhRFAt
         sP0IhhmJwv2xGB2lIFFlQOoAtRbaq0VRd6pQv0tEfEbPIh/dYshBiEbk9EMfiCu9Zm
         tzRuCc4jRRuMNfi3GooKSLdY1oMh377rmRKeNgf9kILpK1IriZ+sHZ6eV+SQfgELWT
         DuSCs8+AtE6e5Dlrv6TntebhI/gIOF20wQ+WyaQtnNRrnh9kBRy3CJvQV+PLIgE4cf
         1mgxywUJLJ6a1NG26OBC5RqRkvVYO/T/f+dY/1zc9bTe8//G9qS+pwMpddncHqpUKg
         6DsmW5ZkFGC0Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso1628335e87.1;
        Mon, 22 May 2023 01:11:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDwnKJn06bxhDhMfX8ioQdqKYyoLLm8eqau8+uqhosMR2r3xoeW9
        xMA6CRfYhecktE9o+qBiiUlDP7O73fDpQnmyrf0=
X-Google-Smtp-Source: ACHHUZ7/qMl1XWR7ltpbNPCtiPTtKqL17whtbAfTLnLM0Bi+omns44QuOfWWInwctOw0bUMzgFRXzoRc9ohRA+eA/OM=
X-Received: by 2002:a05:6512:208:b0:4f3:7a59:d19 with SMTP id
 a8-20020a056512020800b004f37a590d19mr2788096lfo.59.1684743107599; Mon, 22 May
 2023 01:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230512194302.1662230-1-nicholasbishop@google.com>
In-Reply-To: <20230512194302.1662230-1-nicholasbishop@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 May 2023 10:11:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERDgT1cM-2P4M=DBGU0Wzbc-zewGsJjLQoQHpC3ds-4g@mail.gmail.com>
Message-ID: <CAMj1kXERDgT1cM-2P4M=DBGU0Wzbc-zewGsJjLQoQHpC3ds-4g@mail.gmail.com>
Subject: Re: [PATCH] efi/esrt: Allow ESRT access without CAP_SYS_ADMIN
To:     Nicholas Bishop <nicholasbishop@google.com>,
        Peter Jones <pjones@redhat.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 12 May 2023 at 21:43, Nicholas Bishop <nicholasbishop@google.com> wrote:
>
> Access to the files in /sys/firmware/efi/esrt has been restricted to
> CAP_SYS_ADMIN since support for ESRT was added, but this seems overly
> restrictive given that the files are read-only and just provide
> information about UEFI firmware updates.
>
> Remove the CAP_SYS_ADMIN restriction so that a non-root process can read
> the files, provided a suitably-privileged process changes the file
> ownership first. The files are still read-only and still owned by root by
> default.
>
> Signed-off-by: Nicholas Bishop <nicholasbishop@google.com>

Seems reasonable to me. Peter?

> ---
>  drivers/firmware/efi/esrt.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index d5915272141f..aab96ab64a1a 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -95,10 +95,6 @@ static ssize_t esre_attr_show(struct kobject *kobj,
>         struct esre_entry *entry = to_entry(kobj);
>         struct esre_attribute *attr = to_attr(_attr);
>
> -       /* Don't tell normal users what firmware versions we've got... */
> -       if (!capable(CAP_SYS_ADMIN))
> -               return -EACCES;
> -
>         return attr->show(entry, buf);
>  }
>
> --
> 2.40.1.606.ga4b1b128d6-goog
>
