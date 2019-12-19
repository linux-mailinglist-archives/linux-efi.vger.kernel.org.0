Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A37C126094
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2019 12:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLSLM3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Dec 2019 06:12:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56625 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726656AbfLSLM3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Dec 2019 06:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576753948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNULH+k2CFQi/deM4A9aVESdQYUaA3amWSBWAP+3UBc=;
        b=SEeSmVMsEJWKOHUmvV1xwWZuvlDUxzcK4M37kWAlicIKTBd2WqLZ6fWF4wbFRQ1eOfwmKe
        iICHk3Irl7FjE58IsqaBFsFBbh7z5dqZA69n1IqPmP50jmkpfi3nhtKoI6lP8u53qrdS6m
        Fni7b4O8FkczNHMuydnC3WEktThIKuA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-Nt7mn1ZFOO6GJZf65kjb5A-1; Thu, 19 Dec 2019 06:12:22 -0500
X-MC-Unique: Nt7mn1ZFOO6GJZf65kjb5A-1
Received: by mail-wr1-f70.google.com with SMTP id f15so2246573wrr.2
        for <linux-efi@vger.kernel.org>; Thu, 19 Dec 2019 03:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DNULH+k2CFQi/deM4A9aVESdQYUaA3amWSBWAP+3UBc=;
        b=YRD9BGwmURwZYiat9xdBVhq3WzmAVIGapXhsFnKH8pIPrXuLP0XXvj47JrNpb0tJQ4
         JDHnsJz+7atF2nKsU4Vs9oGMEG8MMOgocZMUxOMosBNSqwyoFKaXUJal7y1IeuHwhonz
         7PGXIvncnMSi2WGQLYcjvTa4vgNPbpu9L4hobP/XNH+kJobjG/63p712dw8QOw+xfbDx
         EM/ocfaZvNdeTK7QON596PQnaXkX9T67yM0woSi6HGHHvEqoKK9XQroyx4HXDQxqpMkr
         FEdTy6Eoj7VoAFdNMKenBH5rz6ldv/iGBWlk6RVBhM6vAGYXEeXRtZb32KVIIJfEy8GB
         WwGA==
X-Gm-Message-State: APjAAAUTTsuS4bgO60IlcZlb7FZIyuKJH/TpRrGHYl72gNuQIZVtYTHo
        60ic+K8488f11mQui3qI+gOCf727mMkr3vNuEW2jV4pk/DAsZGZFAVGCGh6D5nJvDe25rcFgIqZ
        rtiJfwHJdrRc02jpcXjcn
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr9158763wrp.2.1576753940929;
        Thu, 19 Dec 2019 03:12:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzL21tdsuCZNJlEKzwSsJY4FYVaQt46oK/avHDxb66l96HeJcz9FFP2N/sT/y5LH5AMe/vHfw==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr9158739wrp.2.1576753940698;
        Thu, 19 Dec 2019 03:12:20 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id w20sm5789405wmk.34.2019.12.19.03.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 03:12:20 -0800 (PST)
Subject: Re: [PATCH v2 00/21] efi/x86: confine type unsafe casting to mixed
 mode
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
References: <20191218170139.9468-1-ardb@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <34f13f7f-a79c-16be-638a-c9267b740bce@redhat.com>
Date:   Thu, 19 Dec 2019 12:12:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218170139.9468-1-ardb@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 18-12-2019 18:01, Ard Biesheuvel wrote:
> Currently, we support mixed mode (64-bit Linux running on 32-bit firmware)
> by explicitly reasoning about pointer sizes for every call into the
> firmware: on x86, there are 32-bit and 64-bit versions of each protocol
> interface, and each call gets routed via one of the two, depending on the
> native size of the firmware.
> 
> There is a lot of casting and pointer mangling involved in this, and as
> a result, we end up with much less coverage in terms of type checking by
> the compiler, due to the indirection via an anonymous, variadic thunking
> routine.
> 
> This peculiarity of x86 is also leaking into generic EFI code, which is
> shared with ia64, arm64, ARM and likely RiscV in the future. So let's
> try to clean this up a bit.
> 
> The approach taken by this series is to replace the 32/64 bit distinction
> with a distinction between native calls and mixed mode calls, where the
> former can be either 32 or 64 bit [depending on the platform] and use
> the ordinary native protocol definitions, while mixed mode calls retain
> the existing casting/thunking approach based on the 32-bit protocol
> definitions.
> 
> Given that GCC now supports emitting function calls using the MS calling
> convention, we can get rid of all the wrapping and casting, and emit the
> indirect calls directly.
> 
> Changes since v1:
> - Substantially more cleanup work to simplify and hide the mixed mode handling
>    in generic EFI code.
> - Get rid of all the pointless passing around of sys_table_arg
> - Incorporate an updated version of Matthew's PCI DMA disable patch using EFI
>    events to defer poking the busmaster bits until after all the ordinary
>    ExitBootServices() callbacks have executed.
> 
> Code can be found here
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efistub-x86-cleanup-v2
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Matthew Garrett <matthewgarrett@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>

I've merged ardb/efistub-x86-cleanup-v3 into my local tree for testing I will let
you know if I see any unexpected side-effects. I've set CONFIG_EFI_DISABLE_PCI_DMA=n
for now.

I did notice one small cosmetic issue with the last patch:

 > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
 > index bcc378c19ebe..da2f5fc862aa 100644
 > --- a/drivers/firmware/efi/Kconfig
 > +++ b/drivers/firmware/efi/Kconfig
 > @@ -215,6 +215,28 @@ config EFI_RCI2_TABLE
 >
 >   	  Say Y here for Dell EMC PowerEdge systems.
 >
 > +config EFI_DISABLE_PCI_DMA
 > +       bool "Clear Busmaster bit on PCI bridges during ExitBootServices()"
 > +       help

The bool and help here seem to be indented by 7 spaces rather then by a tab.

Regards,

Hans


