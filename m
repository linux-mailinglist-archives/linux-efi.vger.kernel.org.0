Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE1781C1C
	for <lists+linux-efi@lfdr.de>; Sun, 20 Aug 2023 04:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHTCkL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Aug 2023 22:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHTCj5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Aug 2023 22:39:57 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D44381EB;
        Sat, 19 Aug 2023 18:04:01 -0700 (PDT)
Received: from [172.27.2.41] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 37K13SJJ2218312
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 19 Aug 2023 18:03:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 37K13SJJ2218312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023081101; t=1692493410;
        bh=qfXMJSMvd16f6xy9L3N9tjGXeYmkKh8AHAqkwUQ6BYE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qyfuGRvd9Si3Fv5j+GpJXDkN5ciaFrjw8F5/1rC55743XVDP/CUTOf9XCTTlyN3bK
         lsPZe+tLinrisrwHOgDax4S1Doy03IUOhu5vgZjF0ydMNUi+ju9RhQ4kjyXca17wA4
         I1PzvlYGkBnYZLPHneZ2+RuQC8OVSanKcbXXQ19CipRPabQ33DiC8VsKz5Aso6fo4f
         7MMLqqG43J+Sjd0U3uHOJrLFLHc54wngMjiHe5zhK91HKEcCmVIWJlQEFlPCF6f7Pr
         dWq+uM6lLzcbTBoTHT0ml3+ZJEj0kzlgr7g+OKi8EefWWayWxvX430u5jh/zw9m6tc
         SCPhxwUQ7K89Q==
Message-ID: <46832047-567e-5699-fbec-8c3e991cfe0a@zytor.com>
Date:   Sat, 19 Aug 2023 18:03:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/17] x86/boot: Drop CRC-32 checksum and the build tool
 that generates it
Content-Language: en-US
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
 <20230818134422.380032-18-ardb@kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20230818134422.380032-18-ardb@kernel.org>
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
> The only remaining task carried out by the boot/tools/build.c build tool
> is generating the CRC-32 checksum of the bzImage. This feature was added
> in commit
> 
>    7d6e737c8d2698b6 ("x86: add a crc32 checksum to the kernel image.")
> 
> without any motivation (or any commit log text, for that matter). This
> checksum is not verified by any known bootloader, and given that
> 
> a) the checksum of the entire bzImage is reported by most tools (zlib,
>     rhash) as 0xffffffff and not 0x0 as documented,
> b) the checksum is corrupted when the image is signed for secure boot,
>     which means that no distro ships x86 images with valid CRCs,
> 
> it seems quite unlikely that this checksum is being used, so let's just
> drop it, along with the tool that generates it.
> 

This one I have concerns with.

	-hpa

