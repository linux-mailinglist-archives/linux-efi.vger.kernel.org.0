Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517777CDAFC
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjJRLvj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 07:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjJRLvi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 07:51:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CC0F7
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 04:51:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9becde9ea7bso864255766b.0
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697629894; x=1698234694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+pNMB4mKSI0KFpYQC57T63NKoavnDeh6DEnCbA+Zis=;
        b=ba0jFsvZTQuTixojjgGa0DHGtRtdx3rsNzJkoCqc528hFb6NEeJTXCtRm3qTc8Wq4h
         c/tjGhSK5Gp48Dcrgba7BbRCq6ESkEAJngEUFyRSEeggTk0GTSyj3A81jcCwRhui1AHU
         J1TMzzaK44nxaocQ2iIGacWmcWfXw38I82Tn0qvvxW2kM8pR0Y2/iDSltSJhD/Y4H91y
         6IqA2vXf6t6W54fspW8Nqys0RGQgJtIr6UUbwtds8UgiEdY3HdJk9yousawNkhFWo4yg
         5aEC9o7Do2J7wPAf1co8MOgb0qFdwnSNbybUlPN7pI9SUa5WhZHarpGy/nvBMa72eXCm
         9O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629894; x=1698234694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+pNMB4mKSI0KFpYQC57T63NKoavnDeh6DEnCbA+Zis=;
        b=rbQVKQYhNGXGA2D7vwNM5zegp9R6RKF20NqpOqNmErMQ90/f1MO7O5WUCJEd3o+Rk6
         r65VzdXHrYiL+cU83bPDySXMWhP1TrG+phBgR+ITQOXQj48ufarT2H/idum1gC5aac0n
         wq30ONZxdo6x0EkeS1KQOCLC6PJB7ao2TuDBQrpvfYE2j8WATtkPLwsFqSO74KImaqBi
         5kTSHtdhLWn8V/PjchqqwglJyqwf8EOVJs0jOLiJJRS68UC7h7svrEwCtLccGBXnlZec
         5bd7ErmC6ikqPIWW68U5rM6PGCDgyN/BRKKFMbiyPqnf8EPnOLme64O13pgfmMroJCo2
         /44A==
X-Gm-Message-State: AOJu0YzLVW+1fqpV3DVu4IfWywtw81uw2IZ0a8Zk4sR7U7/tYJGGs9zu
        OyGw1aB4Tv5eQr32JM8viRxUkA==
X-Google-Smtp-Source: AGHT+IHVGHdWUYfSVUVtp3aBaAbjLHgjYUT69XS+TtF0Y9LMTanxlycF28sFKc7R7EQzT3Ip1h+9Ew==
X-Received: by 2002:a17:906:6a16:b0:9ba:8ed:ea58 with SMTP id qw22-20020a1709066a1600b009ba08edea58mr4299229ejc.30.1697629894407;
        Wed, 18 Oct 2023 04:51:34 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
        by smtp.gmail.com with ESMTPSA id z18-20020a17090674d200b009920e9a3a73sm1557458ejl.115.2023.10.18.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:51:33 -0700 (PDT)
Date:   Wed, 18 Oct 2023 14:51:31 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v9 5/6] efivarfs: force RO when remounting if SetVariable
 is not supported
Message-ID: <ZS_Gw-eIKsGgm-Lf@hera>
References: <20231013074540.8980-1-masahisa.kojima@linaro.org>
 <20231013074540.8980-6-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013074540.8980-6-masahisa.kojima@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

I found some more issues in the rest of the patches and Kojima-san will
have to respin those.  This is a straight up fix though of an existing
issue.  Any chance you can pick it up separately? If you need any changes
let me know and I can respin it without the rest of the series

Thanks
/Ilias

On Fri, Oct 13, 2023 at 04:45:38PM +0900, Masahisa Kojima wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> If SetVariable at runtime is not supported by the firmware we never assign
> a callback for that function. At the same time mount the efivarfs as
> RO so no one can call that.  However, we never check the permission flags
> when someone remounts the filesystem as RW. As a result this leads to a
> crash looking like this:
>
> $ mount -o remount,rw /sys/firmware/efi/efivars
> $ efi-updatevar -f PK.auth PK
>
> [  303.279166] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [  303.280482] Mem abort info:
> [  303.280854]   ESR = 0x0000000086000004
> [  303.281338]   EC = 0x21: IABT (current EL), IL = 32 bits
> [  303.282016]   SET = 0, FnV = 0
> [  303.282414]   EA = 0, S1PTW = 0
> [  303.282821]   FSC = 0x04: level 0 translation fault
> [  303.283771] user pgtable: 4k pages, 48-bit VAs, pgdp=000000004258c000
> [  303.284913] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [  303.286076] Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
> [  303.286936] Modules linked in: qrtr tpm_tis tpm_tis_core crct10dif_ce arm_smccc_trng rng_core drm fuse ip_tables x_tables ipv6
> [  303.288586] CPU: 1 PID: 755 Comm: efi-updatevar Not tainted 6.3.0-rc1-00108-gc7d0c4695c68 #1
> [  303.289748] Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.04-00627-g88336918701d 04/01/2023
> [  303.291150] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  303.292123] pc : 0x0
> [  303.292443] lr : efivar_set_variable_locked+0x74/0xec
> [  303.293156] sp : ffff800008673c10
> [  303.293619] x29: ffff800008673c10 x28: ffff0000037e8000 x27: 0000000000000000
> [  303.294592] x26: 0000000000000800 x25: ffff000002467400 x24: 0000000000000027
> [  303.295572] x23: ffffd49ea9832000 x22: ffff0000020c9800 x21: ffff000002467000
> [  303.296566] x20: 0000000000000001 x19: 00000000000007fc x18: 0000000000000000
> [  303.297531] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaac807ab54
> [  303.298495] x14: ed37489f673633c0 x13: 71c45c606de13f80 x12: 47464259e219acf4
> [  303.299453] x11: ffff000002af7b01 x10: 0000000000000003 x9 : 0000000000000002
> [  303.300431] x8 : 0000000000000010 x7 : ffffd49ea8973230 x6 : 0000000000a85201
> [  303.301412] x5 : 0000000000000000 x4 : ffff0000020c9800 x3 : 00000000000007fc
> [  303.302370] x2 : 0000000000000027 x1 : ffff000002467400 x0 : ffff000002467000
> [  303.303341] Call trace:
> [  303.303679]  0x0
> [  303.303938]  efivar_entry_set_get_size+0x98/0x16c
> [  303.304585]  efivarfs_file_write+0xd0/0x1a4
> [  303.305148]  vfs_write+0xc4/0x2e4
> [  303.305601]  ksys_write+0x70/0x104
> [  303.306073]  __arm64_sys_write+0x1c/0x28
> [  303.306622]  invoke_syscall+0x48/0x114
> [  303.307156]  el0_svc_common.constprop.0+0x44/0xec
> [  303.307803]  do_el0_svc+0x38/0x98
> [  303.308268]  el0_svc+0x2c/0x84
> [  303.308702]  el0t_64_sync_handler+0xf4/0x120
> [  303.309293]  el0t_64_sync+0x190/0x194
> [  303.309794] Code: ???????? ???????? ???????? ???????? (????????)
> [  303.310612] ---[ end trace 0000000000000000 ]---
>
> Fix this by adding a .reconfigure() function to the fs operations which
> we can use to check the requested flags and deny anything that's not RO
> if the firmware doesn't implement SetVariable at runtime.
>
> Fixes: f88814cc2578 ("efi/efivars: Expose RT service availability via efivars abstraction")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  fs/efivarfs/super.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 0f6e4d223aea..942e748a4e03 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -15,6 +15,7 @@
>  #include <linux/magic.h>
>  #include <linux/statfs.h>
>  #include <linux/notifier.h>
> +#include <linux/printk.h>
>
>  #include "internal.h"
>
> @@ -300,8 +301,19 @@ static int efivarfs_get_tree(struct fs_context *fc)
>  	return get_tree_single(fc, efivarfs_fill_super);
>  }
>
> +static int efivarfs_reconfigure(struct fs_context *fc)
> +{
> +	if (!efivar_supports_writes() && !(fc->sb_flags & SB_RDONLY)) {
> +		pr_err("Firmware does not support SetVariableRT. Can not remount with rw\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct fs_context_operations efivarfs_context_ops = {
>  	.get_tree	= efivarfs_get_tree,
> +	.reconfigure	= efivarfs_reconfigure,
>  };
>
>  static int efivarfs_init_fs_context(struct fs_context *fc)
> --
> 2.30.2
>
