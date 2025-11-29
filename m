Return-Path: <linux-efi+bounces-5722-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D23C93CAB
	for <lists+linux-efi@lfdr.de>; Sat, 29 Nov 2025 11:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F894E108F
	for <lists+linux-efi@lfdr.de>; Sat, 29 Nov 2025 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB62ECEB9;
	Sat, 29 Nov 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E/nDU8i7"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073B2EA743
	for <linux-efi@vger.kernel.org>; Sat, 29 Nov 2025 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764413092; cv=none; b=TRME/K8HGf3dVpc2eMNGsPP+iWScx+KORoCodcG9YOSxNlRYlM5RJWb6TIz73IWvJnLhVy/33UbFZusS+O9l6o5aOgJekpWXuZeERHJq2zjxuQd022SrF9wERKno9MKggo18wLhFS+6e7QotGrw7f8F6X5yPptkbB0hK6rC+3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764413092; c=relaxed/simple;
	bh=jBNMJfhcmfm6Hju8KLaxPyGcOjpDnkjDcqkSjbT60Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTsNUbVyCGrPDy2m4IQ6rT2f3iwpDknewQG20mkrZINUIWH4fo2qrQFXx53wvI2rrtOPvx/QKF7zMQlfxwGwR4oTd4UzpLYXLqn3JVbqdUxGN1PKYHYHVwvHmSXb/SgPxqi8VzFSxTLM09lQ6ao21uzFrMhSvP8LfTxbm+NQiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E/nDU8i7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f36mTSggbyI0dVO3vnsBztOs/jf0ytqm9wEXzpDFCMQ=; b=E/nDU8i72g0Ihjwchz06E2GthB
	l93SbM3lO27L7UF38bvJxnJETJqry8DzvaYHGKZaY90/9lL9YQo0mkZEaW5yS/8S9e9jOStT/IWD+
	icRhdwMrUTRSqHVkTGOztM7SgxiHktOQMn+vfJmbzHITQi3TasQ5KsSlSJ/fqBB5encKRKO6rHSVq
	MB/Dqp3JZCpK1dJKAqsnXjNRkN3IBQ3MCTzRvVbKKFF7E7ZqtGbwa8yJjR2zi/klwiksNwfl19Mdu
	lBX41PNXfYXtnzZMbofCPL1f376Fr6cyI0y9jA1CLoN7vLS5qw9JIIhaXxk/Kjp+VawWtf3C5MZUH
	9sDtzkEQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vPIRO-006lpi-LB; Sat, 29 Nov 2025 11:44:34 +0100
Message-ID: <660c5469-086f-40b4-99f1-72c1bc613ece@igalia.com>
Date: Sat, 29 Nov 2025 10:44:33 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFX] efi: sysfb_efi: Fix simpledrmfb on Steam Deck
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Javier Martinez Canillas <javierm@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-efi@vger.kernel.org
References: <20251128150403.11567-1-tvrtko.ursulin@igalia.com>
 <ce41c2d1-c659-4632-8469-761762202800@suse.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <ce41c2d1-c659-4632-8469-761762202800@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 28/11/2025 17:07, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for the bug report
> 
> Am 28.11.25 um 16:04 schrieb Tvrtko Ursulin:
>> I am not sure how is simpledrmfb on top of EFI supposed to work, but at
>> least at the moment it appears there is a missing link in the "discovery"
>> of frame buffer parameters.
>>
>> What I can see is that EFI GOP reads some parameters from the firmware 
>> and
>> infers the other, such as in this case problematic pitch, or stride.
> 
> The pitch/stride value comes from the firmware via pixels_per_scanline [1].
> 
> Can you verify that this value is really 800 instead of 832 (eq 3328 
> bytes) ?
> 
> [1] https://elixir.bootlin.com/linux/v6.17.9/source/drivers/firmware/ 
> efi/libstub/gop.c#L493

I actually got confused a bit in following the flow so thank you for 
asking me to double check.

GOP actually reports 1280x800 with a stride of 5120. So it kind of 
reports a rotated view already, kind of.

Only when the rotation quirk from efifb_dmi_swap_width_height triggers 
the stride gets incorrectly recalculated:

		u16 temp = screen_info.lfb_width;

		screen_info.lfb_width = screen_info.lfb_height;
		screen_info.lfb_height = temp;
		screen_info.lfb_linelength = 4 * screen_info.lfb_width;

So this is where things go wrong, well, they actually go wrong a little 
bit even earlier, in gop.c:

	si->lfb_size = si->lfb_linelength * si->lfb_height;

Which potentially underestimates the fb size. If GOP was forward looking 
enough to give us the size we could derive the pitch based on size..

Anyway, as it stands it looks a quirk in sysfb_apply_efi_quirks looks it 
is required to fix it all up.

I am a bit uneasy about declaring the fb size larger than what was 
implied by firmware provided pitch * height * depth but limited to a 
specific DMI match and if it looks visually okay I think it is a safe 
assumption the quirked size is actually correct and safe.
>> One could be easily excused in thinking that pitch cannot be reliably
>> inferred, since different display hardware has differing alignment
>> requirements, so it is unclear how is hardware agnostic solution supposed
>> to work.
>>
>> In the specific case of the Steam Deck hardware we have a 800x1280 native
>> panel which is also installed rotated 90 degrees counter clockwise.
>>
>> Firmware appears to set up the pitch as 3328, while GOP assumes 3200,
>> based of a width * bpp calculation.
> 
> 832 is a multiple of 64, while 800 is not. I've seen this over- 
> allocation in other context as well.
> 
>>
>> When this incorrect pitch propagates through (rather complicated) fbcon
>> and DRM call paths, the end result is corrupted rendering all until the
>> amdgpu takes over the fbdev.
>>
>> Simplistic solution in this patch is to add a DMI quirk to the EFI
>> frame buffer setup code.
>>
>> Apart from the incorrect pitch, the quirk also does the swapping of the
>> width and height. Apart from setting the correct fbcon dimensions this
>> one also allows the quirk from drm_get_panel_orientation_quirk() to
>> report the correct orientation.
> 
> Nice
> 
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: "Christian König" <christian.koenig@amd.com>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Rodrigo Siqueira <siqueira@igalia.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: linux-efi@vger.kernel.org
>> ---
>>   drivers/firmware/efi/sysfb_efi.c | 48 ++++++++++++++++++++++++++++++--
>>   1 file changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/ 
>> sysfb_efi.c
>> index 1e509595ac03..84d9049bb2cb 100644
>> --- a/drivers/firmware/efi/sysfb_efi.c
>> +++ b/drivers/firmware/efi/sysfb_efi.c
>> @@ -231,6 +231,18 @@ static const struct dmi_system_id 
>> efifb_dmi_system_table[] __initconst = {
>>       {},
>>   };
>> +struct efifb_mode_fixup {
>> +    unsigned int width;
>> +    unsigned int height;
>> +    unsigned int pitch;
>> +};
>> +
>> +static const struct efifb_mode_fixup efifb_steamdeck_mode_fixup = {
>> +    .width = 1280,
>> +    .height = 800,
>> +    .pitch = 3328,
>> +};
>> +
>>   /*
>>    * Some devices have a portrait LCD but advertise a landscape 
>> resolution (and
>>    * pitch). We simply swap width and height for these devices so that 
>> we can
>> @@ -281,6 +293,24 @@ static const struct dmi_system_id 
>> efifb_dmi_swap_width_height[] __initconst = {
>>               DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X91"),
>>           },
>>       },
>> +    {
>> +        /* Valve Steam Deck (Jupiter) */
>> +        .matches = {
>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
>> +            DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
>> +            DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
>> +        },
>> +        .driver_data = (void *)&efifb_steamdeck_mode_fixup,
>> +    },
>> +    {
>> +        /* Valve Steam Deck (Galileo) */
>> +        .matches = {
>> +            DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
>> +            DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
>> +            DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
>> +        },
>> +        .driver_data = (void *)&efifb_steamdeck_mode_fixup,
>> +    },
>>       {},
>>   };
>> @@ -351,17 +381,31 @@ static struct fwnode_handle efifb_fwnode;
>>   __init void sysfb_apply_efi_quirks(void)
>>   {
>> +    const struct dmi_system_id *match;
>> +
>>       if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
>>           !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
>>           dmi_check_system(efifb_dmi_system_table);
>> -    if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
>> -        dmi_check_system(efifb_dmi_swap_width_height)) {
> 
> Could we keep swap_width_height a separate list?
> 
> The for loop would then be a full override-display list.
> 
>> +    if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>> +        return;
>> +
>> +    for (match = dmi_first_match(efifb_dmi_swap_width_height);
>> +         match;
>> +         match = dmi_first_match(match + 1)) {
>> +        const struct efifb_mode_fixup *data = match->driver_data;
>>           u16 temp = screen_info.lfb_width;
>>           screen_info.lfb_width = screen_info.lfb_height;
>>           screen_info.lfb_height = temp;
>>           screen_info.lfb_linelength = 4 * screen_info.lfb_width;
> 
> FTR: This calculation has always been wrong. We need to take the 
> lfb_depth into account. No need to fix this here; just so you know.

I can add a patch to replace with screen_info.lfb_depth / BITS_PER_BYTE?

>> +
>> +        if (data && data->pitch &&
>> +           data->width == screen_info.lfb_height &&
>> +           data->height == screen_info.lfb_width) {
>> +            screen_info.lfb_linelength = data->pitch;
>> +            screen_info.lfb_size = data->pitch * data->width;
>> +        }
> 
> If we have a separate fix-up list, we can make this much nicer:
> 
> if (data->width)
>     // assign data->width
> if (data->height)
>     // assign data->width
> if (data->data)
>     // assign data->pitch
> 
> and then recompute linelength and size

I thought the approach of looking at the multiple parameters at the same 
time, similar how drm_get_panel_orientation_quirk() does it, is safer. 
Ie. we don't want to edit unless the whole mode matches the expectation.

Regards,

Tvrtko


