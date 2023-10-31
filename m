Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3EC7DD7BD
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 22:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJaV0M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 17:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjJaV0L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 17:26:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B57CF5
        for <linux-efi@vger.kernel.org>; Tue, 31 Oct 2023 14:26:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FE7C433C7
        for <linux-efi@vger.kernel.org>; Tue, 31 Oct 2023 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698787567;
        bh=Cju6IOMABdjLkX3ialSCVggzXYMAhTpwJVMYqG/jxaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g2l//ru/46Oy8YJH2ERWtmZkSCr+A9q7mwlOZAXg7uCCfltRMqtdHgxt7FxTaJRCq
         NvU18D/1HdNiJ6heRECg5oFeAsjfaVSNRbefzW0xacvyzuYlSDuhTYopf1nJbmi+zS
         rorFiO5zyUqiEwQAxpll2sfmS8AlLDxcSbQumN6SfiqSvDdmDE4jaft9kmAoIkcJG2
         9LHLnygjmZkVZvp5hHk1SBy+G4ETXY5QXQfyFWqsbx53msB9yaxFmq8zUk+SoAO+k1
         UgudKSRL6SenX/FG0twgW1Trx/2XgZJaecBBSv0pv93oyt0r2KqDQTfw/dwhmeVa2d
         Ouk3SdkVzXrVQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso88376651fa.2
        for <linux-efi@vger.kernel.org>; Tue, 31 Oct 2023 14:26:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YzvYckam5JzDYP/D8Rx4U3QPCBMUjmZkU1JvOiP0vZzU91x1ddo
        FR+uY8xmHPFzO8iOFocuuo00msp6H3uz37Lyce0=
X-Google-Smtp-Source: AGHT+IEG7nBMubLWceVolfh1V2EKw8MmJ4ESgDwnxeRxsEtEXWq0WcLt1B5YCPnSYX01Elmj537fniMYtB5h+VM5YJ0=
X-Received: by 2002:a2e:1554:0:b0:2bf:eccb:548 with SMTP id
 20-20020a2e1554000000b002bfeccb0548mr10494650ljv.0.1698787565491; Tue, 31 Oct
 2023 14:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-magenta-mouflon-of-prestige-70b64a@nitro>
In-Reply-To: <20231031-magenta-mouflon-of-prestige-70b64a@nitro>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Oct 2023 22:25:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEdLMSWNPPjPj-eoHHM0hWujjuuUN2QQOEkDoQ-z7aedg@mail.gmail.com>
Message-ID: <CAMj1kXEdLMSWNPPjPj-eoHHM0hWujjuuUN2QQOEkDoQ-z7aedg@mail.gmail.com>
Subject: Re: PSA: migrating linux-efi to new vger infrastructure
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Oct 2023 at 21:22, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Good day!
>
> I plan to migrate the linux-efi@vger.kernel.org list to the new infrastructure
> this week. We're still doing it list-by-list to make sure that we don't run
> into scaling issues with the new infra.
>
> The migration will be performed live and should not require any downtime.
> There will be no changes to how anyone interacts with the list after
> migration is completed, so no action is required on anyone's part.
>
> Please let me know if you have any concerns.
>

Thanks Konstantin.
