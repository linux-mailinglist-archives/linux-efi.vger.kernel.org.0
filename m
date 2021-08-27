Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9CB3F9A96
	for <lists+linux-efi@lfdr.de>; Fri, 27 Aug 2021 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbhH0OF3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Aug 2021 10:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244821AbhH0OF3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Aug 2021 10:05:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EF0E60F25;
        Fri, 27 Aug 2021 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630073080;
        bh=44QU6B7UHXV3vt00RetJeW55g4tXsNAqT+PxKxmKGW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J+6xVaYLfmFda9E6Xfhy0qs0X9nojl1N1jKgKnf29vo2E+t0XQe/kUanKV/z99W84
         pbhJQEjZ/EhGQfrsw++H9maezou3hFkMTLrpZ0CzESHMx9i82Qj7XnV+D4JNJRwYQj
         N3SZ8+FLL+A/ss7yv+7Nx7NTudIU9TiEytsxjEWf28PJzgTBJC8jEtUEGl4rk6hX3U
         bPtSIpJpRMTu8SL9J2hGmHj6IUwMS2aagl80rOK6yVzU3ER2v3sKfJb28bw8zq8xDU
         Om3H9oCwJ/EUp7qNtHNCSPpx70MQL7VTi0TfCSNnMXeDZ3cac+a9FQbQ4JkThywhpX
         cuclQsvrluoNg==
Received: by mail-oi1-f180.google.com with SMTP id o185so9608777oih.13;
        Fri, 27 Aug 2021 07:04:40 -0700 (PDT)
X-Gm-Message-State: AOAM533hDtv8pjBeRl8nZJs7FHUeqIQQN8JNGT8VsXLpwQDi2Ide76y7
        NGsdNhUMkPIlWjJ2YccmEvYpIKdiFBbUZZpv7cg=
X-Google-Smtp-Source: ABdhPJwl71FxMHI1K9ik8wmBUJnxFjkrkeihPqyYzOH5gE4Mtgs5Qb/AGyKRNVnOmEfMW2i9q/U9tfZP1r1/Vk7pUJA=
X-Received: by 2002:aca:ea54:: with SMTP id i81mr6560180oih.174.1630073079708;
 Fri, 27 Aug 2021 07:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210823115654.45405-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20210823115654.45405-1-xueshuai@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Aug 2021 16:04:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEY=kK9+LfJtemBZND_u-+nP7qu6cNJxxLfQJ6CV1Ub8Q@mail.gmail.com>
Message-ID: <CAMj1kXEY=kK9+LfJtemBZND_u-+nP7qu6cNJxxLfQJ6CV1Ub8Q@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: check section header more appropriately
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhangliguang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 23 Aug 2021 at 13:57, Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>
> When checking a generic status block, we iterate over all the generic data
> blocks. The loop condition checks that the generic data block is valid.
> Because the size of data blocks (excluding error data) may vary depending
> on the revision and the revision is contained within the data block, we
> should ensure that enough of the current data block is valid appropiriately
> for different revision.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Applied, thanks.

> ---
>  drivers/firmware/efi/cper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index e15d484b6a5a..e80706d9e78a 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -635,7 +635,7 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>         data_len = estatus->data_length;
>
>         apei_estatus_for_each_section(estatus, gdata) {
> -               if (sizeof(struct acpi_hest_generic_data) > data_len)
> +               if (acpi_hest_get_size(gdata) > data_len)
>                         return -EINVAL;
>
>                 record_size = acpi_hest_get_record_size(gdata);
> --
> 2.20.1.12.g72788fdb
>
