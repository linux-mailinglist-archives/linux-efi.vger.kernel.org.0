Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A287820F2
	for <lists+linux-efi@lfdr.de>; Mon, 21 Aug 2023 02:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjHUAh4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 20 Aug 2023 20:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjHUAhz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 20 Aug 2023 20:37:55 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C479A1;
        Sun, 20 Aug 2023 17:37:54 -0700 (PDT)
Received: from [172.27.2.41] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 37L0axcK2825490
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 20 Aug 2023 17:36:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 37L0axcK2825490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023081101; t=1692578227;
        bh=LS0t3eJMC3oEeUYwbzUIhxo77/Qn4L8MnyaKAPL1sZU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ptgg4K8diZPQ+mazet/va6n+IKglvW07tcdbfTmv1EqMD8Kk7ifL7+4H5gT0s9xaq
         leLQglh/BgQrkBwAYebD39ue6Gz82b/OmCFiK/hPW0NVkhc4KLqEObZaSbOiZ6Z9Bb
         +aRVM5uZoSWV4O0GPJkbxm1wPnpRmaRpwe2DyZJCdfQw60zRyAkrJfbMKFPzvlemh0
         1PNZ5RTv9/77glDJgq+fNpcWHp1ggsyXswRQl343Bpmwpf21ueCxBbdZguByvuemyN
         aexrxG52oXEg+U31k7wgimmxMPsPOI82RtNOTzFf5ibCzUXbMerh37912WVzXJjNBk
         KTMg+1dtiUUBg==
Message-ID: <d8c2f362-bfe9-560a-541c-a298f8685be1@zytor.com>
Date:   Sun, 20 Aug 2023 17:37:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/17] x86/boot: Drop CRC-32 checksum and the build tool
 that generates it
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
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
 <46832047-567e-5699-fbec-8c3e991cfe0a@zytor.com>
 <CAMj1kXG5X2ZUNs2W8o5_c83fznRDjLjPZcEqEgfpFUBS1DX5Pg@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAMj1kXG5X2ZUNs2W8o5_c83fznRDjLjPZcEqEgfpFUBS1DX5Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/20/23 05:57, Ard Biesheuvel wrote:
> 
> I understand. I deliberately put this change at the very end because I
> was anticipating some debate on this.
> 
> Do you have any recollection of why this CRC32 was introduced in the
> first place? The commit logs are empty and the lore thread doesn't
> contain any justification either.
 >

The justification is that firmware is notoriously unreliable and gives 
the boot loader an independent way to verify the load and have a 
fallback, rather than jumping to the kernel and having the decompressor 
fail.

At this time it is impossible to know what might rely on it. The EFI 
signing issue aside, there are a ton of Linux bootloaders for non-EFI 
systems using the BIOS or raw kernel entry points - and there is no 
telling what those environments might do.

	-hpa
