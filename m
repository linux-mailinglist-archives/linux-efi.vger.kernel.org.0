Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0990781C1A
	for <lists+linux-efi@lfdr.de>; Sun, 20 Aug 2023 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjHTCkG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Aug 2023 22:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjHTCjz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Aug 2023 22:39:55 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F32381EF;
        Sat, 19 Aug 2023 18:04:01 -0700 (PDT)
Received: from [172.27.2.41] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 37K12dkW2217952
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 19 Aug 2023 18:02:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 37K12dkW2217952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023081101; t=1692493374;
        bh=Kn+YwMsGGBaii7cfbRQ8m922QywiwBH4TdkaZAGSsBg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aK/Qcy8rxC1aMdVJ8Tqc7ChMDPhvWFI/YXESanf2dYPfJCObTwI76kfavi1IpsVdO
         QXqhG4vZjz0pPud3UqGeZbY8+7NPQNijzbEk7dtq9lpbxgyH12/cuSc/MVR5EeAOoP
         eJ42lifPHCSKiU5eGtT8/mnMO5FP5pdRFq9xO6XQcbSeCJBTKfVBB++crbMh4I85sZ
         OMnbUYPh+NLiuPHEl++1+cYBWphslfcWKN5Q13td1miMt2Vmjayk6TYifUP/oeODt0
         j2W0vTP3DvOKtXe1+n4DQZOibqPWsNFKoUdSdiqKIvv1KcDd0vlPa+jf3d2A7oSx8K
         7GtP8HhRluZxA==
Message-ID: <583bf766-5351-24b6-dbd6-fc5db6a7b2f8@zytor.com>
Date:   Sat, 19 Aug 2023 18:02:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/17] x86/boot: Remove the 'bugger off' message
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>
References: <20230818134422.380032-1-ardb@kernel.org>
 <20230818134422.380032-5-ardb@kernel.org>
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20230818134422.380032-5-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/18/23 06:44, Ard Biesheuvel wrote:
> Ancient (pre-2003) x86 kernels could boot from a floppy disk straight from
> the BIOS, using a small real mode boot stub at the start of the image
> where the BIOS would expect the boot record (or boot block) to appear.
> 
> Due to its limitations (kernel size < 1 MiB, no support for IDE, USB or
> El Torito floppy emulation), this support was dropped, and a Linux aware
> bootloader is now always required to boot the kernel from a legacy BIOS.
> 
> To smoothen this transition, the boot stub was not removed entirely, but
> replaced with one that just prints an error message telling the user to
> install a bootloader.
> 
> As it is unlikely that anyone doing direct floppy boot with such an
> ancient kernel is going to upgrade to v6.5+ and expect that this boot
> method still works, printing this message is kind of pointless, and so
> it should be possible to remove the logic that emits it.
> 
> Let's free up this space so it can be used to expand the PE header in a
> subsequent patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org
>

Good riddance.

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
