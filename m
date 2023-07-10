Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A53574DEF3
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jul 2023 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGJUPZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jul 2023 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJUPZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jul 2023 16:15:25 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03547BB;
        Mon, 10 Jul 2023 13:15:22 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxV_HZZqxkZ0YDAA--.9710S3;
        Tue, 11 Jul 2023 04:15:21 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbSPDZqxkILcnAA--.63575S3;
        Tue, 11 Jul 2023 04:15:17 +0800 (CST)
Message-ID: <e7e87325-0b95-2b1c-5652-7f119948b4bd@loongson.cn>
Date:   Tue, 11 Jul 2023 04:14:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] fbdev/hyperv_fb: Include <linux/screen_info.h>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        javierm@redhat.com, decui@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, kys@microsoft.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-efi@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20230710075848.23087-1-tzimmermann@suse.de>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230710075848.23087-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxbSPDZqxkILcnAA--.63575S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1rJw1kKFWUuF13Kw43XFc_yoW5urWxpF
        48AFy3CrWrAr1xGa17G342kF90gw15Cryj9F9rKw1YyryYyr1q9r47uFsxW398Jr45GF13
        tFy3Ww1jka4DuagCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUstxhDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 2023/7/10 15:58, Thomas Zimmermann wrote:
> Include <linux/screen_info.h> to get the global screen_info state.
> Fixes the following errors:
>
>>> drivers/video/fbdev/hyperv_fb.c:1033:10: error: use of undeclared identifier 'screen_info'
>      1033 |                 base = screen_info.lfb_base;
>           |                        ^
>     drivers/video/fbdev/hyperv_fb.c:1034:10: error: use of undeclared identifier 'screen_info'
>      1034 |                 size = screen_info.lfb_size;
> 	 |                        ^
>>> drivers/video/fbdev/hyperv_fb.c:1080:3: error: must use 'struct' tag to refer to type 'screen_info'
>      1080 |                 screen_info.lfb_size = 0;
> 	 |                 ^
> 	 |                 struct
>>> drivers/video/fbdev/hyperv_fb.c:1080:14: error: expected identifier or '('
>      1080 |                 screen_info.lfb_size = 0;
> 	 |                            ^
>     drivers/video/fbdev/hyperv_fb.c:1081:3: error: must use 'struct' tag to refer to type 'screen_info'
>      1081 |                 screen_info.lfb_base = 0;
> 	 |                 ^
> 	 |                 struct
>     drivers/video/fbdev/hyperv_fb.c:1081:14: error: expected identifier or '('
>      1081 |                 screen_info.lfb_base = 0;
> 	 |                            ^
>     drivers/video/fbdev/hyperv_fb.c:1082:3: error: must use 'struct' tag to refer to type 'screen_info'
>      1082 |                 screen_info.orig_video_isVGA = 0;
> 	 |                 ^
> 	 |                 struct
>      drivers/video/fbdev/hyperv_fb.c:1082:14: error: expected identifier or '('
>      1082 |                 screen_info.orig_video_isVGA = 0;
> 	 |                            ^
>      8 errors generated.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307101042.rqehuauj-lkp@intel.com/
> Fixes: 8b0d13545b09 ("efi: Do not include <linux/screen_info.h> from EFI header")
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


> Cc: "K. Y. Srinivasan" <kys@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Cc: Haiyang Zhang <haiyangz@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Cc: Wei Liu <wei.liu@kernel.org> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Cc: Dexuan Cui <decui@microsoft.com> (supporter:Hyper-V/Azure CORE AND DRIVERS)
> Cc: Helge Deller <deller@gmx.de> (maintainer:FRAMEBUFFER LAYER)
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sui Jingfeng <suijingfeng@loongson.cn>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS)
> Cc: linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
> Cc: dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER)
> ---
>   drivers/video/fbdev/hyperv_fb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 1ae35ab62b29..b331452aab4f 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -48,6 +48,7 @@
>   #include <linux/aperture.h>
>   #include <linux/module.h>
>   #include <linux/kernel.h>
> +#include <linux/screen_info.h>
>   #include <linux/vmalloc.h>
>   #include <linux/init.h>
>   #include <linux/completion.h>


Ah, I also overlook this one. :-)

