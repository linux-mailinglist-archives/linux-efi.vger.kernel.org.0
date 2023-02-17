Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E0B69AF93
	for <lists+linux-efi@lfdr.de>; Fri, 17 Feb 2023 16:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBQPdH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Feb 2023 10:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBQPdG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Feb 2023 10:33:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540C6CA1E
        for <linux-efi@vger.kernel.org>; Fri, 17 Feb 2023 07:33:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19AB61DF1
        for <linux-efi@vger.kernel.org>; Fri, 17 Feb 2023 15:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4B1C4339E
        for <linux-efi@vger.kernel.org>; Fri, 17 Feb 2023 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676647984;
        bh=ltzaxKyqVg8EEJP7B7pgXDe2NY3u/1D6sXpu7Q7FoAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xu56h8VtGApfXoFiMQAMZjxwg1Nksr2gm16gUkR6XybTz/wUGY/aQkAHBCOLC8TRy
         4oRC8v1TMvpDBb4lbEskSQ1gaweRVC5eo+UXwDgbTCjpgauV/HlrWtotXtm+h4KIwf
         n4LUFYHUo3IzmTjcnFye+6qbRXZfaaA5S+2w/FNP5i09Rctq1HRVyDfgL3yjU47h+R
         EvU1Emc71e1jj9OJ9lzkp59jvA1INXgCFAW3j4PRVy0o6iBEyf6yMOlVm5MKSj5pJB
         +fEn0QxN2alnwMsp5coGm7/zt+Ngn2PwEmfLxEYZIyOehIEWwFKs6WjsEI0Sy+wo6J
         8gkesKRG3v+9g==
Received: by mail-lf1-f49.google.com with SMTP id o3so2111387lfo.3
        for <linux-efi@vger.kernel.org>; Fri, 17 Feb 2023 07:33:04 -0800 (PST)
X-Gm-Message-State: AO0yUKXvkzEIjFRgo0bWFgdOjUS3DAeM4cRwy3spvOMaG/BhG1Dfl9cl
        VaiQ93IBUNngr3Daw00F5/j4PITw4z1bSnIB0uM=
X-Google-Smtp-Source: AK7set+81k9MkokWF1c9bWw5Z9xnjiEnJkDpYjXD0udnkfsIc2+e7Hr0xfoVYJ9YbXo7hT9+y/IXtrXvbutGhcnTNFM=
X-Received: by 2002:a05:6512:4dd:b0:4d5:ca32:68a2 with SMTP id
 w29-20020a05651204dd00b004d5ca3268a2mr463469lfq.7.1676647982114; Fri, 17 Feb
 2023 07:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20230215115045.9396-1-darrell.kavanagh@gmail.com> <fca0366b-fa32-b756-b149-876976f3a5da@redhat.com>
In-Reply-To: <fca0366b-fa32-b756-b149-876976f3a5da@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 17 Feb 2023 16:32:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGP5FkEMeQzhuu=VUyhbW6yhCs8_5AifcwhR8qsbsG08w@mail.gmail.com>
Message-ID: <CAMj1kXGP5FkEMeQzhuu=VUyhbW6yhCs8_5AifcwhR8qsbsG08w@mail.gmail.com>
Subject: Re: [PATCH v2] firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad
 Duet 3
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darrell Kavanagh <darrell.kavanagh@gmail.com>,
        linux-efi@vger.kernel.org, maxime@cerno.tech
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 15 Feb 2023 at 15:58, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/15/23 12:50, Darrell Kavanagh wrote:
> > Another Lenovo convertable which reports a landscape resolution of
> > 1920x1200 with a pitch of (1920 * 4) bytes, while the actual framebuffer
> > has a resolution of 1200x1920 with a pitch of (1200 * 4) bytes.
> >
> > Signed-off-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>
> > ---
> > Changes in v2:
> >       - Improve commit message
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>

Thanks. I've queued this up in efi/next.
