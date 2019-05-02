Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508BA115CF
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 10:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBIxo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 04:53:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51924 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfEBIxo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 May 2019 04:53:44 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so1983343itk.1
        for <linux-efi@vger.kernel.org>; Thu, 02 May 2019 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1X9ipyrjBCgysbixO7mllniKFp0zrqAX+YLVm+Qy1S0=;
        b=yWsXoM80YUTgdMB6oO2DDbeU8DPDbcmA+PC+5sSaToOqaTpIKARGyOV/boF39l6Q1e
         0aVuAgi17sn11G4czZdsXIIJkkaqL5RwBNxp2WmHWGQ0do7X2cYx5WD9ZEZgo4pNA4eM
         jQeldBHxndo5h2SYoCG+q9P+M52Zgdto9W0VS1nmNRxaq9lQxMuYeHsQMqJOD1PiJBJL
         ZbHxxKVWhhaxPoCfu7IaDYqyN9xb9KuFVUCbvvm5JUBTMgU9qJ+Cy7s2nVCb+dPkiDWV
         FNdrFBiSFR1EnoD5PIjaMUH7Ka1MQhnuK2F3cSwxw0wBXszsZbDKh7ybJR69Ihjcb57D
         zysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1X9ipyrjBCgysbixO7mllniKFp0zrqAX+YLVm+Qy1S0=;
        b=Qqdj1oJpEi42Jxs9POUpEXLFGh3zcIs+KbckAzrZmiL3Jv4UxeUXPLfDQnkDsaBnlz
         qkoO99tVnnl5kIr+Fj4q5UpzKyWZgUXA/gOYWJF1PVgFsAzzvjoQP6ZBituv4UCWJw3w
         lhSnWMuvEpwpsSOeV3BDg8s4lCX/XVq9J//MyLQXqOirID7cisE8w3UQmntEfy02wVn8
         kAcFNuc6nMK9MAFWnYCUvSXXy2bJZoVvk+c2O0oU9ripLpC3WRBrXOwJ5IkMwCgN5kt7
         peIHK/yqLWtxfftEX1BdGx5zqXmtDlKP7EIkAl2RP8DdVk5Ht7Eq/AmAnCt3v+zbN10U
         BpPA==
X-Gm-Message-State: APjAAAXVJng0Sm3ld83M/Y+rThFjZ6KF03epl/BKzaNO0Rcf3jLoDDXz
        2lpqPIiHfanMCUwtwhAzGMH9BYsAPvPcABych1d8bQ==
X-Google-Smtp-Source: APXvYqx/xmKUay1hTDkSxXbGcJPVRadVdpD5CE7BMBOOohtgLIELm0otn+yCvfcjJqOQCM5tLVNFRPp2zEAvFndl3JM=
X-Received: by 2002:a24:b342:: with SMTP id z2mr1327414iti.121.1556787223814;
 Thu, 02 May 2019 01:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040441.30372-1-jlee@suse.com>
In-Reply-To: <20190502040441.30372-1-jlee@suse.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 May 2019 10:53:31 +0200
Message-ID: <CAKv+Gu9mjtNEWN-w4ix7VJMZ_kk-Qf6FfYFRu2mCosaAjMA4Vg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] efi: add a function to convert the status value to string
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 May 2019 at 06:04, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> This function can be used to convert EFI status value to string
> for printing out debug message. Using this function can improve
> the readability of log.
>
> v2.

Please move the changelog out of the commit log (move it below the ---
further down)

> - Changed the wording in subject and description.
> - Moved the marco immediately after the status value definitions.
> - Turned into a proper function instead of inline.
>

You missed my point here. A proper function means the function in a .c
file, and only the declaration in a .h file. This way, you are still
duplicating the literal strings into every object file that references
this function.

> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  include/linux/efi.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 54357a258b35..6f3f89a32eef 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -42,6 +42,34 @@
>  #define EFI_ABORTED            (21 | (1UL << (BITS_PER_LONG-1)))
>  #define EFI_SECURITY_VIOLATION (26 | (1UL << (BITS_PER_LONG-1)))
>
> +#define EFI_STATUS_STR(_status) \
> +case EFI_##_status: \
> +       return "EFI_" __stringify(_status);
> +
> +static __attribute__((unused)) char *
> +efi_status_to_str(unsigned long status)
> +{
> +       switch (status) {
> +       EFI_STATUS_STR(SUCCESS)
> +       EFI_STATUS_STR(LOAD_ERROR)
> +       EFI_STATUS_STR(INVALID_PARAMETER)
> +       EFI_STATUS_STR(UNSUPPORTED)
> +       EFI_STATUS_STR(BAD_BUFFER_SIZE)
> +       EFI_STATUS_STR(BUFFER_TOO_SMALL)
> +       EFI_STATUS_STR(NOT_READY)
> +       EFI_STATUS_STR(DEVICE_ERROR)
> +       EFI_STATUS_STR(WRITE_PROTECTED)
> +       EFI_STATUS_STR(OUT_OF_RESOURCES)
> +       EFI_STATUS_STR(NOT_FOUND)
> +       EFI_STATUS_STR(ABORTED)
> +       EFI_STATUS_STR(SECURITY_VIOLATION)
> +       default:
> +               pr_warn("Unknown efi status: 0x%lx", status);
> +       }
> +
> +       return "Unknown efi status";
> +}
> +
>  typedef unsigned long efi_status_t;
>  typedef u8 efi_bool_t;
>  typedef u16 efi_char16_t;              /* UNICODE character */
> --
> 2.16.4
>
