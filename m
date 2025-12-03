Return-Path: <linux-efi+bounces-5768-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A28C9E69F
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 10:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D702F4E07A8
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEC2D73B0;
	Wed,  3 Dec 2025 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K0bvXf9Y"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467362BDC33
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752953; cv=none; b=m9uAmsh/EbrsSSRYuEX+VsQV7yB2QisD/bFvsJwFzNfMdnEFUSSubHT2O1suD6jrHErgfyuRKbOsjmt7cUj1ll7w4TleAe/yClIS+TpfsM8iqftxmg4y0MwREoLytlOXx4YXDO+Op2hmDGHuZtMlujhr7qH/t/PLgKU6C/WZsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752953; c=relaxed/simple;
	bh=sr2MdP1Z+H+rDQTQurif/tJfV94mm104IEnackiqegw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAnrexv6gJkGRPXZFLE4+PpMDY+uRJrRE5/mDPU+EguJq9fAKfd4Cx8cBAibBpQic+71Fsh5LRFNm7iIYLjfLihZj7emOWZZVdHdiAxWPpdeR1U/N3pwzcf0exGDYVPs1C/Lx8x2YIMEPNKJ2jHYuODaKtvvCwDvHhmoZtBOzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K0bvXf9Y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M0TA48JOuAKiafjC0jutlOo1jAMzbLRZq9sc6SET82s=; b=K0bvXf9Y5UF+dYkBdwdfK368bM
	90hcONTVJdfZ0a0hEAdNPc7ksbrzEffYKG8enLle4UBLkQZn6OGlgVq/z9pU4e0Be/O3UlpJNPE6L
	JDNGmNOb3RP96naIHHCqzrDcyeUCOrwzU/9WylZHhGgnfTnlCJAWaNlobE8vmMHZ5d2lTihoj9IoV
	kKI3kudPO1vNdW5dnN1sD56l7HWGBxWML8toLzZ8DP154+aakQwi+tzx3IMjx0ywXTncBeiNbDSNP
	02duCZ03NAOnO60f8F8DpiCrJmS+WD25esfEQt0dnfnpKaJmr/SpGmJbNI4SmA+4mwULAnBP54bsu
	P9GgtpNw==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vQir8-008Bvo-PZ; Wed, 03 Dec 2025 10:09:02 +0100
Message-ID: <f3af30e3-99a0-42db-b8e6-bcf7b5739daf@igalia.com>
Date: Wed, 3 Dec 2025 09:09:02 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi: sysfb_efi: Fix efidrmfb and simpledrmfb on Valve
 Steam Deck
To: Ard Biesheuvel <ardb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Thomas Zimmermann <tzimmermann@suse.de>, Melissa Wen <mwen@igalia.com>,
 linux-efi@vger.kernel.org
References: <20251202141025.723-1-tvrtko.ursulin@igalia.com>
 <20251202141025.723-4-tvrtko.ursulin@igalia.com>
 <CAMj1kXGbo9Td5ydyO=rqkb28b6DUw9-H0bkJ9PhGKz0V8LufnQ@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <CAMj1kXGbo9Td5ydyO=rqkb28b6DUw9-H0bkJ9PhGKz0V8LufnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/12/2025 15:34, Ard Biesheuvel wrote:
> On Tue, 2 Dec 2025 at 15:10, Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
>>
>> Valve Steam Deck has a 800x1280 portrait screen installed in a landscape
>> orientation. The firmware offers a software rotated 1280x800 mode which
>> GRUB can be made to switch to when displaying a boot menu. If this mode
>> was selected frame buffer drivers will see this fake mode and fbcon
>> rendering will be corrupted.
>>
>> Lets therefore add a selective quirk inside the current "swap with and
>> height" handling, which will detect this exact mode and fix it up back to
>> the native one.
>>
>> This will allow the DRM based frame buffer drivers to detect the correct
>> mode and, apply the existing panel orientation quirk, and render the
>> console in landscape mode with no corruption.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: linux-efi@vger.kernel.org
>> ---
>>   drivers/firmware/efi/sysfb_efi.c | 69 +++++++++++++++++++++++++++++---
>>   1 file changed, 63 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
>> index 2dea98395784..6458b3193093 100644
>> --- a/drivers/firmware/efi/sysfb_efi.c
>> +++ b/drivers/firmware/efi/sysfb_efi.c
>> @@ -231,6 +231,27 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>>          {},
>>   };
>>
>> +struct efifb_mode_fixup {
>> +       unsigned int width;
>> +       unsigned int height;
>> +       unsigned int pitch;
>> +};
>> +
>> +static const struct efifb_mode_fixup efifb_steamdeck_mode_fixup = {
>> +       /*
>> +        * Valve Steam Deck has a 800x1280 portrait screen installed in a
>> +        * landscape orientation. The firmware offers a software rotated
>> +        * 1280x800 mode which GRUB can be made to switch to when displaying a
>> +        * boot menu. If this mode was selected we need to fix it up back to the
>> +        * native mode so frame buffer drivers can correctly probe, detect the
>> +        * panel orientation quirk based on it, and the console renders with no
>> +        * corruption in the software rotated mode.
>> +        */
> 
> I don't think we need this wall of text. The only material difference
> between this quirk and the other ones is that the pitch is not simply
> 4x the width, but I suspect that in the other cases, it also only
> works when using the Blit() interface, and I guess this is what
> Windows uses.

Ok removed.

>> +       .width = 1280,
>> +       .height = 800,
>> +       .pitch = 3328,
> 
> Can we call this 'linelength' instead?

Done.

>> +};
>> +
>>   /*
>>    * Some devices have a portrait LCD but advertise a landscape resolution (and
>>    * pitch). We simply swap width and height for these devices so that we can
>> @@ -281,6 +302,24 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>>                          DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
>>                  },
>>          },
>> +       {
>> +               /* Valve Steam Deck (Jupiter) */
>> +               .matches = {
>> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
>> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
>> +                       DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
>> +               },
>> +               .driver_data = (void *)&efifb_steamdeck_mode_fixup,
>> +       },
>> +       {
>> +               /* Valve Steam Deck (Galileo) */
>> +               .matches = {
>> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
>> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
>> +                       DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
>> +               },
>> +               .driver_data = (void *)&efifb_steamdeck_mode_fixup,
>> +       },
>>          {},
>>   };
>>
>> @@ -351,16 +390,34 @@ static struct fwnode_handle efifb_fwnode;
>>
>>   __init void sysfb_apply_efi_quirks(void)
>>   {
>> +       const struct dmi_system_id *match;
>> +
>>          if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
>>              !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
>>                  dmi_check_system(efifb_dmi_system_table);
>>
>> -       if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
>> -           dmi_check_system(efifb_dmi_swap_width_height)) {
>> -               swap(screen_info.lfb_width, screen_info.lfb_height);
>> -               screen_info.lfb_linelength = (unsigned)screen_info.lfb_depth *
>> -                                            screen_info.lfb_width /
>> -                                            BITS_PER_BYTE;
>> +       if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>> +               return;
>> +
>> +       for (match = dmi_first_match(efifb_dmi_swap_width_height);
>> +            match;
>> +            match = dmi_first_match(match + 1)) {
>> +               const struct efifb_mode_fixup *data = match->driver_data;
>> +
>> +               if (!data ||
>> +                   (data->width == screen_info.lfb_width &&
>> +                    data->height == screen_info.lfb_height)) {
>> +                       swap(screen_info.lfb_width, screen_info.lfb_height);
>> +
>> +                       if (data && data->pitch) {
>> +                               screen_info.lfb_linelength = data->pitch;
>> +                               screen_info.lfb_size = data->pitch * data->width;
> 
> 
>> +                       } else {
>> +                               screen_info.lfb_linelength = (unsigned)screen_info.lfb_depth *
> 
> Please don't use bare 'unsigned' as a type. Is it really needed in the
> first place? Is it because it gets promoted to (signed int) otherwise?

Yep. I made it unsigned int. Was just trying to keep the line length 
under control, otherwise I would have never used bare unsigned. :)

> 
> 
>> +                                                            screen_info.lfb_width /
>> +                                                            BITS_PER_BYTE;
>> +                       }
>> +               }
> 
> I'd prefer to avoid all this boilerplate, and use a callback instead
> (but perhaps combined with the previous fix):
> 
> static int __init efifb_swap_width_height(const struct dmi_system_id *id)
> {
>          swap(screen_info.lfb_width, screen_info.lfb_height);
>          screen_info.lfb_linelength = screen_info.lfb_depth *
> screen_info.lfb_width / BITS_PER_BYTE;
> 
>          return 1;
> }
> 
> and then add the handling of id->data in this patch.
> 
> You'll need to add .callback fields to the dmi_system_id array,
> though, but this only takes up space that is already statically
> allocated anyway.
> 
> Then, the code in sysfb_apply_efi_quirks() just becomes
> 
>          if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI)
>              dmi_check_system(efifb_dmi_swap_width_height);

Okay done in v2 as well.

Regards,

Tvrtko




