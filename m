Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82605468682
	for <lists+linux-efi@lfdr.de>; Sat,  4 Dec 2021 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbhLDRZg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Dec 2021 12:25:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36156 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345154AbhLDRZf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Dec 2021 12:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA88960E8C;
        Sat,  4 Dec 2021 17:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8250FC341C0;
        Sat,  4 Dec 2021 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638638529;
        bh=kss5LJXXOIKzYcAiXOd4LQe8tPaaVa8hpEWHOf47pZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ZFnbUVIf7Ph16TBe0sJk0stTgTNMWosAVjYf/gkHxMnGZfCBp9JlWlWO39ctlB84
         cB5f6Z9qqyRi2irs2/cooZhEzpv2DmyHwaBRKWPJCdSZYHhaq3DxHtrBzp+uxHezqO
         bmo/0n25SV1u/a6IlUXMiHCtD+XUvGEAde+lspmQ=
Date:   Sat, 4 Dec 2021 18:22:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Subject: Re: [PATCH v3 5/5] drivers/node: Show in sysfs node's crypto
 capabilities
Message-ID: <YaujvjBFsb3ricUx@kroah.com>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <20211203192148.585399-6-martin.fernandez@eclypsium.com>
 <YaslQCg2G1pWUPVV@kroah.com>
 <CAKgze5Yw6=PjY9+cn=FKX5UsiSon5rVOK_Gc-3Hs8dQspSFaYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgze5Yw6=PjY9+cn=FKX5UsiSon5rVOK_Gc-3Hs8dQspSFaYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 04, 2021 at 01:35:15PM -0300, Martin Fernandez wrote:
> On 12/4/21, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > You forgot a Documentation/ABI/ update for this new sysfs file you
> > added :(
> >
> 
> Damn, I forgot to add it to the patch. It will be in my next patch,
> this is what it looks like:
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-node
> b/Documentation/ABI/testing/sysfs-devices-node
> new file mode 100644
> index 000000000000..ab46fdd3f6a8
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-node
> @@ -0,0 +1,10 @@
> +What:		/sys/devices/system/node/nodeX/crypto_capable
> +Date:		October 2021

October is long gone :(

> +Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
> +Users:		fwupd

Maybe a link to what 'fwupd' is?

> +Description:
> +		This value is 1 if all system memory in this node is
> +		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
> +		system memory is capable of being protected with the
> +		CPU’s memory cryptographic capabilities. It is 0
> +		otherwise.

thanks,

greg k-h
