Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8C7B14CF
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2019 21:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfILTfI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Sep 2019 15:35:08 -0400
Received: from bear.techie.net ([205.134.185.202]:48550 "EHLO bear.techie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfILTfI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 12 Sep 2019 15:35:08 -0400
Received: by bear.techie.net (Postfix, from userid 545)
        id E7E1722A0945; Thu, 12 Sep 2019 15:35:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=techie.net; s=default;
        t=1568316907; bh=PR3Oys8g9aZruQAbK2JjcS9X6DoNsIxCIqWRipF6gP0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QSZkndUvpcsZtmSFOMS6NED1BwZ4CEQ6kHoTeBlW/7c5mP31k/7xeAY2H6nh3rJxB
         DVq1UIQ8TuU9XRKTMBgXV3EWspOBUhwCX9Igq63imkpkeBQm4fsiCxvMpb90ncSysJ
         DSBKFMjQtEi8WCkoEecBcQjhp56EzQPVbCm0HKg0=
Received: from localhost (localhost [127.0.0.1])
        by bear.techie.net (Postfix) with ESMTP id C60E522A0943;
        Thu, 12 Sep 2019 15:35:07 -0400 (EDT)
Date:   Thu, 12 Sep 2019 15:35:07 -0400 (EDT)
From:   Scott Talbert <swt@techie.net>
X-X-Sender: talbert@bear.techie.net
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi: don't iterate over EFI vars pointlessly if no SSDT
 override was specified
In-Reply-To: <20190911233239.5916-1-ard.biesheuvel@linaro.org>
Message-ID: <alpine.DEB.2.21.1909121533270.30174@bear.techie.net>
References: <20190911233239.5916-1-ard.biesheuvel@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Sep 2019, Ard Biesheuvel wrote:

> The kernel command line option efivar_ssdt= allows a EFI variable name
> to be specified which contains an ACPI SSDT table that will be loaded
> into memory by the OS.
>
> Currently, that code will always iterate over the EFI variables and
> compare each name with the provided name, even if the command line
> option wasn't set to begin with.
>
> So bail early when no variable name was provided.
>
> Cc: Scott Talbert <swt@techie.net>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> drivers/firmware/efi/efi.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index ad3b1f4866b3..8f020827cdd3 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -282,6 +282,9 @@ static __init int efivar_ssdt_load(void)
> 	void *data;
> 	int ret;
>
> +	if (!efivar_ssdt[0])
> +		return 0;
> +
> 	ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
>
> 	list_for_each_entry_safe(entry, aux, &entries, list) {

Thanks for the quick fix!

I can confirm this fixes booting on my Mac Pro 2012 system when applied to 
5.3-rc7.

Whenever this makes it in, if it could be targeted for the stable kernels 
as well, that would be appreciated.

Thanks,
Scott
