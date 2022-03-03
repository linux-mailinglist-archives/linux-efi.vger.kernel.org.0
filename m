Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49964CBCB9
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 12:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiCCLeq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 06:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiCCLdo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 06:33:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C238181E42
        for <linux-efi@vger.kernel.org>; Thu,  3 Mar 2022 03:32:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 189B9B824ED
        for <linux-efi@vger.kernel.org>; Thu,  3 Mar 2022 11:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9164C340F1
        for <linux-efi@vger.kernel.org>; Thu,  3 Mar 2022 11:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646307120;
        bh=Zb9RVep7Zc2j8sEmLjkDQpbcUOKTVuFKVDELVhuas3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ro/wLh9YS8hJTMnKkfK0a/SLSYf23GtJ1DxCpEGboM2oBwG58EnuiUhInkb2qVQSg
         gp5dywYod28zm18ocE5u1tHvKApFiOH9cQ5LwvIz9Y4JPwB6WZH8AQIwR1c6Yodbke
         rqpJPiCpiSkidTthX2SWM7lLEewS+aEMdu8fdJKqFa4/gz96lH0WpnlZlk2Jw+ISI1
         i+Fv2nDyEV5AnjY5yzJFAjSy4rUxaoWDUQ3kdrduyiRDGFvrqZAYiBrt+V+J0DgrxT
         AfvpqQQp4aLWCe8e+JxCOyo6T8NwRxlDpXVLx7GSh8nYJ312XlLnAw8D6VyCCagDIn
         PNlr5GChuxBlA==
Received: by mail-yb1-f169.google.com with SMTP id bt13so9619958ybb.2
        for <linux-efi@vger.kernel.org>; Thu, 03 Mar 2022 03:32:00 -0800 (PST)
X-Gm-Message-State: AOAM5322bUuvWk2WmMGLAvoTp3llzCFtBtHmZHtZCuMI3TQD+xYmabFX
        ZjmoUhNCcD9j1X4wjGYo2s/mQllytjeQIUg62k8=
X-Google-Smtp-Source: ABdhPJz6vJyO8Fe7TpEihWLnVONTM9xGvX1pp8UuTyEcJrLr/mXnbmARPgHlYyzHF/kCPAz/XxZCT0LXqEpJOPUwX9Q=
X-Received: by 2002:a25:53c4:0:b0:628:a0de:b4d6 with SMTP id
 h187-20020a2553c4000000b00628a0deb4d6mr6560820ybb.299.1646307119847; Thu, 03
 Mar 2022 03:31:59 -0800 (PST)
MIME-Version: 1.0
References: <894d1598-7b05-9406-5c1a-162b749bb4e8@huawei.com>
 <CAMj1kXH3p3fTF-MKqJ6TAYc3Jm0WRit8u+ugjZdr-ykAR8ahTA@mail.gmail.com>
 <4792d478-edea-6c72-3e08-cf2a390f5a7c@huawei.com> <CAMj1kXH=Sy8m_Zi5PNDqX3GQqFQdXnd1DQkxGhEeM-uovfvVLw@mail.gmail.com>
 <90370cea-a3d2-6ae8-0b9d-71a3a9d97c12@huawei.com>
In-Reply-To: <90370cea-a3d2-6ae8-0b9d-71a3a9d97c12@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Mar 2022 11:31:49 +0000
X-Gmail-Original-Message-ID: <CAMj1kXEUk5ofQvmi8C7A=QX28KO7KfR665ji__AcRL39MP014A@mail.gmail.com>
Message-ID: <CAMj1kXEUk5ofQvmi8C7A=QX28KO7KfR665ji__AcRL39MP014A@mail.gmail.com>
Subject: Re: [Question] Should retain 2M alignment if kernel image is bad
 aligned at entry or BSS overlaps?
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 3 Mar 2022 at 06:14, Kefeng Wang <wangkefeng.wang@huawei.com> wrote=
:
>
>
> On 2022/3/1 20:57, Ard Biesheuvel wrote:
> > On Tue, 1 Mar 2022 at 11:34, Kefeng Wang <wangkefeng.wang@huawei.com> w=
rote:
> >>
...
> >> Do you think the following adjustment make sense or it is definitely w=
rong?
> >>
> > I can only answer this if I understand which problem it solves. Why do
> > you need the 2M alignment in this case?
> > .
>
> Sorry for the late response=EF=BC=8Cmy purpose is that we don't want to e=
nable
> KPTI if
>
> KASLR is disabled. For now, if there are some firmware bug, the kernel
> image is
>
> relocated which lead to kaslr_requires_kpti() returen
> ture(kaslr_offset() > 0).
>
> the change to 2M alignment is a workaround and according to your
> explanation,
>
> I don't think the workaround is necessary.  I want to make sure that the
> above
>
> scene is expected? thanks.
>

I don't think we need this.
