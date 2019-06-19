Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D524B5A7
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jun 2019 11:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfFSJzZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jun 2019 05:55:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38561 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFSJzZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jun 2019 05:55:25 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so7107735ioa.5
        for <linux-efi@vger.kernel.org>; Wed, 19 Jun 2019 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOAHJ6UJcXUgY0jPOCunNfj5a/meWoc55ppSw19pMJw=;
        b=iGE0xIN1mnywsd2Ce9XydaQG42uFJVo1Fa+IZlogrgNPhixIiWWhYhymIB7etaoEpb
         l+e97WPf9990nNcy6IpRVWoEb9DkjiD6cKYCIah98nQeNIaH68oYqHRSpke0+NSTMMXo
         KWZ7n1PPMoOzwCWUP58CEHIFKULymNRzLQVCjuiAbXjapCSFJ2ac6D94aLkgPFn/uYpU
         q6CFuiHP31HNHKFFv0p7KwXpQX9CtjGg1stHcPgjO7707+T4hr4luSJqSJ4CWPKkY201
         4GEG4agouZwtYoKwJQqEeartWFSHACEyaX7y1CVp7QTUa+3ZTHDyxb+hkRzEHNWMeDTq
         CJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOAHJ6UJcXUgY0jPOCunNfj5a/meWoc55ppSw19pMJw=;
        b=ZiKLy49A7wWwOrGU9ox/NpFHtAfeMM50nncvVtgtqSv9rKyrojjSqjXH0rilC0iQQL
         Z/+1bwSZT/OrrUr0V0QFTCb5tvIl3XK7Xh8LJ5ZW5DDIbgr1KeOBox2y+1XcUsnRCLdc
         KVKiPL6Cq6/Ywc0NYSfHKbw+Gbt+s0t2PH4dXmHIhPEmnlZiqA8PbK/0+nLP0YXYlL19
         I95MHF/x9eylrMFzWye5hVKrGjwkVqr42E02VBB37yhPsiuIs2DHiEyPunplsd1dI/Qj
         +lqFufoMj/MvzcYegiOxDxFQvZblqL3KUrInhQY3YTlJAgwpy7veuHcMDMx3AccqXr5A
         Y6Pg==
X-Gm-Message-State: APjAAAU95Q2sQcJ9c9A6eeWJaTmw01OkyzkcEXSOba58RiS7um2krspJ
        CNKXp5DLa+mkpNowVFQ937XJ2WXXFBJyBxHS9z3wIw==
X-Google-Smtp-Source: APXvYqx0Z9rJjYG9CYyxYrAwmG0di3UeYY5aGWznMiIWIfkmqvQTq3YVD+y6EmDduri62FB0Xj+idglWedVL/2PxuWo=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr10934397ion.204.1560938124836;
 Wed, 19 Jun 2019 02:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190615040210.GA9112@hari-Inspiron-1545>
In-Reply-To: <20190615040210.GA9112@hari-Inspiron-1545>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Jun 2019 11:55:14 +0200
Message-ID: <CAKv+Gu9-wiJNxPsVn06dBSU8Gchg8LjV=mi0cThZUWywmt2xzQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: efi: fix gcc warning -Wint-conversion
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        tpmdd-devel@lists.sourceforge.net,
        Matthew Garrett <mjg59@google.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Jarkko, tpmdd, Matthew)

On Sat, 15 Jun 2019 at 06:02, Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> This patch fixes below warning
>
> drivers/firmware/efi/tpm.c:78:38: warning: passing argument 1 of
> =E2=80=98tpm2_calc_event_log_size=E2=80=99 makes pointer from integer wit=
hout a cast
> [-Wint-conversion]
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

I think we already have a fix queued for this, no?

> ---
>  drivers/firmware/efi/tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 74d0cd1..1d3f5ca 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -75,7 +75,7 @@ int __init efi_tpm_eventlog_init(void)
>                 goto out;
>         }
>
> -       tbl_size =3D tpm2_calc_event_log_size(efi.tpm_final_log
> +       tbl_size =3D tpm2_calc_event_log_size((void *)efi.tpm_final_log
>                                             + sizeof(final_tbl->version)
>                                             + sizeof(final_tbl->nr_events=
),
>                                             final_tbl->nr_events,
> --
> 2.7.4
>
