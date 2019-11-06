Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACEF6F1D06
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 18:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfKFR6v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 12:58:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39153 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfKFR6u (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 6 Nov 2019 12:58:50 -0500
Received: from [IPv6:2601:646:8600:3281:adfc:245e:17b7:39c3] ([IPv6:2601:646:8600:3281:adfc:245e:17b7:39c3])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA6Huv4Q961810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 6 Nov 2019 09:57:02 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA6Huv4Q961810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1573063025;
        bh=o6xliq1yN4/+nK8dGGImbCX2PNM/ohBM3dagy4vL754=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=nPgclH4nMtbQ8UfGwygCasCgN6IoeV+EpUy5/3dLimB/x0V+ZOS/1v69nOqvKLjyl
         UVkmYWRjgVm/tTKcbuYFoJsVloKj41EdZJ809hhD5f8GnNLc0EoTOykyJu9LXvBDJx
         egAHsjXTaD8QRl7xOkHrK/R2Cmb2quVJVyJXnMMoZPiqjRikl0dRVC9D4RuI9vED0/
         lZq/abejpSSyvE1WLODo2w9OjR9BfsGRRGBiq9I5nd4NDIjE8g/DXwLfItjrCJX6bD
         fw1bjRVh9jpsFyN7HUXKIsvDS702sx+otdr3QZFgXjtuc9+B6GxF2Eaur+/TQQGZRY
         KEDqPZD/uyQzw==
Date:   Wed, 06 Nov 2019 09:56:48 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20191106170333.GD28380@zn.tnic>
References: <20191104151354.28145-1-daniel.kiper@oracle.com> <20191106170333.GD28380@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/3] x86/boot: Introduce the kernel_info et consortes
To:     Borislav Petkov <bp@alien8.de>,
        Daniel Kiper <daniel.kiper@oracle.com>
CC:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, eric.snowberg@oracle.com, jgross@suse.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
From:   hpa@zytor.com
Message-ID: <3EABBAB2-5BEF-4FEE-8BB4-9EB4B0180B10@zytor.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On November 6, 2019 9:03:33 AM PST, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Mon, Nov 04, 2019 at 04:13:51PM +0100, Daniel Kiper wrote:
>> Hi,
>>=20
>> Due to very limited space in the setup_header this patch series
>introduces new
>> kernel_info struct which will be used to convey information from the
>kernel to
>> the bootloader=2E This way the boot protocol can be extended regardless
>of the
>> setup_header limitations=2E Additionally, the patch series introduces
>some
>> convenience features like the setup_indirect struct and the
>> kernel_info=2Esetup_type_max field=2E
>
>That's all fine and dandy but I'm missing an example about what that'll
>be used for, in practice=2E
>
>Thx=2E

For one thing, we already have people asking for more than 4 GiB worth of =
initramfs, and especially with initramfs that huge it would make a *lot* of=
 sense to allow loading it in chunks without having to concatenate them=2E =
I have been asking for a long time for initramfs creators to split the kern=
el-dependent and kernel independent parts into separate initramfs modules=
=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
