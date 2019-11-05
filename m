Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA34F0899
	for <lists+linux-efi@lfdr.de>; Tue,  5 Nov 2019 22:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfKEVne (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Nov 2019 16:43:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45391 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbfKEVne (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 5 Nov 2019 16:43:34 -0500
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA5LeY98676567
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 5 Nov 2019 13:40:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA5LeY98676567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1572990035;
        bh=hV95SYGgMVR5wGxxOALwv/ps4w4vExuRTEInenwJJ/8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nXSmzhHh3MMQiHdNjLkOYKgl+nxPFIG9UR1AlYj0pB1u/YFIeiEOSUxo0D4V7Z52P
         DuOOHXX3pN3t3HPiT/HWLYRpAHfwBSBW85fVcO52n6xIoDfb5kfXr3saCRpsgjjz4F
         rz9WpEnNMhEI2gAKERTR/q+Er5zCtOar+BnEzg5+riWFrc6Qf8rgqAJQ6lo9+piMUE
         ugWD97HlNeJipb9ecQ5q8ZkamOHSXie9U5EL/pF0YDyKMODesaKW7dS8wssyCi92Ee
         2T0gwFp7Zgx5l+cKaq714MOAZDGtjbnsnnvXRwLsf5hNVK8u0oxsouwiRPVlSZZjjC
         7I7HgRVitwnmg==
Subject: Re: [PATCH v5 0/3] x86/boot: Introduce the kernel_info et consortes
To:     Daniel Kiper <daniel.kiper@oracle.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        jgross@suse.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d45aa4da-57fd-757f-3f82-d88449f057ce@zytor.com>
Date:   Tue, 5 Nov 2019 13:40:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104151354.28145-1-daniel.kiper@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2019-11-04 07:13, Daniel Kiper wrote:
> Hi,
> 
> Due to very limited space in the setup_header this patch series introduces new
> kernel_info struct which will be used to convey information from the kernel to
> the bootloader. This way the boot protocol can be extended regardless of the
> setup_header limitations. Additionally, the patch series introduces some
> convenience features like the setup_indirect struct and the
> kernel_info.setup_type_max field.
> 
> Daniel
> 

Looks great!  Ship it!

Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>

	-hpa
