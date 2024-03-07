Return-Path: <linux-efi+bounces-763-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0EC875398
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 16:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F590B280E4
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389B129A77;
	Thu,  7 Mar 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCbS3NPX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AD1E897
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826125; cv=none; b=XdI8tWrF/k5OsdH1xIGfCq5+GmPU6FOmg0laXB5/hFV2XF73mMK90/TnXAlJ+/YaQouFdH82LE1cK6gpi6iO47kabLkV2sBVeGhR4oTPJ8XW7fuYJk3ve3wYcDWlXhnUV3CqOJAmMrF4XIXwr0r20AUAtfwrat2QyrVeND6kTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826125; c=relaxed/simple;
	bh=zHGMmWnWiKQrTXEY7GZlpm+D70dGGbpwk8TskBKZ59I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swiXVy9XCZC6s5PwEqyxPV0hjyDhMCETcgnkPGzXROqXr3kI6lVfVQ4MFh74YaJQcP4xZWRYHy0WrDQT6SkQhPB7tN6gfP2xGpzmLSYCGXR7AmQT3ZKk631LxJx/PwV27Ex0NRbJiSryv0wuihg7Ymr160pkJXLfZkfFCLcWirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCbS3NPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13727C433C7
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709826125;
	bh=zHGMmWnWiKQrTXEY7GZlpm+D70dGGbpwk8TskBKZ59I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FCbS3NPXk6tBw+KhFeAllHEmQr+AWrlBHJz2uOVlkbSeanNkE6NZG//Ka83YxJp4h
	 l8rDFyuvm/bry3JAYNp/Gr5bnoPMJJRJkeKzgJIHMCnToN15BXslTbZak1ckP6UB74
	 iN3FyCh28QK8jzwI6tMs3YXJjLgKbhuNtwsdxxnldP9X+7X65FKqqroK1e44DNXAmz
	 LkkZFyrQPefri8X5c8MGu2xJGj5hCUK/O9qtmUSwG22kgJgsmLv2qnr2hx21zsdJeN
	 lDeOj6NuyrnZTdXlOYz+zS2CccHecy/0eq65Lw0tLxB8/a9+W+bpF25O29S+wm5k9H
	 hLRYsUB6ZLv3w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d094bc2244so14768891fa.1
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 07:42:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNZBp39VmZNXcmchzBtF6Hh+/DDr8AQwicuBsOXk6nhG0R/cVCujTOzutWOHFHWnzjG5LZMzVqK+4rzWreKdmFEiNzprKGCqs6
X-Gm-Message-State: AOJu0Ywa4nSpTG4g51c2vYM77BXxk/VOBHChSyVP2VFKxCn8obgc0vY+
	e3rJvhMtET4r9taPBhwnSAcAxQcGeFs5LF8Y1FT8Zklkb+IS6dtgBc9cDpBFnMnKTnaNpNc7uOQ
	4qj2uA0JHDQ5F2xp+C41Lwvwjx0M=
X-Google-Smtp-Source: AGHT+IGwCzUZedG94yVB6j9/q4VV/JwtpeeUSoI7kk3w8225Rhx9fQAV1bQhOoT1II3kaBkAmMLw+/6clJkQZ+BG/q0=
X-Received: by 2002:a2e:2e09:0:b0:2d2:45e0:f154 with SMTP id
 u9-20020a2e2e09000000b002d245e0f154mr1694736lju.26.1709826123012; Thu, 07 Mar
 2024 07:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0229a87e-fb19-4dad-99fc-4afd7ed4099a@collabora.com>
 <CAMj1kXE166VdJLWSWo7_3MDw4V3zSuYRx44Z7yqyj5mQVOdDCA@mail.gmail.com>
 <CAMj1kXGFLwsgPo9Xy_-9gaOUUO=wDd_K12ccYUhP1nWf3KLb0w@mail.gmail.com>
 <CAMj1kXG3ySsqU0v5dnC2V+xiKGxdFnY_WSOFzrqb0sr9gDT7Zw@mail.gmail.com> <ee598ddd-5f23-45a7-9233-f7de1bd9364e@linux.intel.com>
In-Reply-To: <ee598ddd-5f23-45a7-9233-f7de1bd9364e@linux.intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Mar 2024 16:41:51 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEmRqLD7+9nNxBmyxAp8O2iRQ6wfeJS=Qrks4+ivv673Q@mail.gmail.com>
Message-ID: <CAMj1kXEmRqLD7+9nNxBmyxAp8O2iRQ6wfeJS=Qrks4+ivv673Q@mail.gmail.com>
Subject: Re: [Bug Report] Bug in "efi/libstub: Add get_event_log() support for
 CC platforms"
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Ard Biesheuvel <ardb+git@google.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 16:36, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 3/7/24 3:30 AM, Ard Biesheuvel wrote:
> > On Thu, 7 Mar 2024 at 12:13, Ard Biesheuvel <ardb@kernel.org> wrote:
> >> On Thu, 7 Mar 2024 at 12:08, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>> Hi Muhammad,
> >>>
> >>> Thanks for the report.
> >>>
> >>> On Thu, 7 Mar 2024 at 12:02, Muhammad Usama Anjum
> >>> <usama.anjum@collabora.com> wrote:
> >>>> Hi,
> >>>>
> >>>> The recent patch:
> >>>> 276805fb9c305: efi/libstub: Add get_event_log() support for CC platforms
> >>>> has introduced
> >>>> #define EFI_CC_EVENT_LOG_FORMAT_TCG_2   0x00000002
> >>>>
> >>>> But EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 has the same numerical value:
> >>>> #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
> >>>>
> >>>> Thus there is dead code in efi_retrieve_tcg2_eventlog() i.e, multiple if
> >>>> conditions with (version == 2) I'm unable to decide on what is wrong and
> >>>> what is right here. Please have a look.
> >>>>
> >>> Why is this a problem? The compiler will recognize this and simplify
> >>> the conditional. The code as written is semantically correct, the fact
> >>> that the symbolic constants resolve to the same numerical value is
> >>> just an implementation detail.
> >> Ah hold on. I see what you mean now:
> >>
> >> if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> >> final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
> >> + else if (version == EFI_CC_EVENT_LOG_FORMAT_TCG_2)
> >> + final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
> >>
> >> Yes, that is broken.
> > Could we fix it like this perhaps?
> >
> > --- a/drivers/firmware/efi/libstub/tpm.c
> > +++ b/drivers/firmware/efi/libstub/tpm.c
> > @@ -75,8 +75,7 @@
> >          *
> >          * CC Event log also uses TCG2 format, handle it same as TPM2.
> >          */
> >        if (version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2) {
> >             /*
> >              * The TCG2 log format has variable length entries,
> >              * and the information to decode the hash algorithms
> > @@ -109,10 +108,11 @@
> >      * Figure out whether any events have already been logged to the
> >      * final events structure, and if so how much space they take up
> >      */
> >    if (version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2)
> >        final_events_table =
> >            get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID) ?:
> >            get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
>
> Looks good to me. If there is a concern that a TPM config table may exists
> even in CC case, we can get the table pointer under protocol check and pass
> it as argument to this function.
>

Yeah, that makes sense. I'll fold this into the patch too.

I did realize, though, that we are still missing some pieces to allow
the kernel to make use of this. Only the TCG2 final events log is
accessed by the kernel proper, and AFAICT, this all happens in the
context of a char driver attached to a TPM device.

So I'd like to understand if there are any plans to follow up?






> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index c35f99f259c1..2ef1e4cd6bb2 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -49,12 +49,12 @@ void efi_enable_reset_attack_mitigation(void)
>
>  static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_location,
>                                        efi_physical_addr_t log_last_entry,
> -                                      efi_bool_t truncated)
> +                                     efi_bool_t truncated,
> +                                     struct efi_tcg2_final_events_table *final_events_table)
>  {
>         efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
>         efi_status_t status;
>         struct linux_efi_tpm_eventlog *log_tbl = NULL;
> -       struct efi_tcg2_final_events_table *final_events_table = NULL;
>         unsigned long first_entry_addr, last_entry_addr;
>         size_t log_size, last_entry_size;
>         int final_events_size = 0;
> @@ -109,10 +109,6 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>          * Figure out whether any events have already been logged to the
>          * final events structure, and if so how much space they take up
>          */
> -       if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> -               final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
> -       else if (version == EFI_CC_EVENT_LOG_FORMAT_TCG_2)
> -               final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
>         if (final_events_table && final_events_table->nr_events) {
>                 struct tcg_pcr_event2_head *header;
>                 int offset;
> @@ -152,6 +148,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>
>  void efi_retrieve_eventlog(void)
>  {
> +      struct efi_tcg2_final_events_table *final_events_table = NULL;
>         efi_physical_addr_t log_location = 0, log_last_entry = 0;
>         efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
>         int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> @@ -170,6 +167,8 @@ void efi_retrieve_eventlog(void)
>                                                 &log_location, &log_last_entry,
>                                                 &truncated);
>                 }
> +               if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> +                       final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
>         } else {
>                 efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
>                 efi_cc_protocol_t *cc = NULL;
> @@ -179,6 +178,7 @@ void efi_retrieve_eventlog(void)
>                         return;
>
>                 version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
> +              final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
>                 status = efi_call_proto(cc, get_event_log, version, &log_location,
>                                         &log_last_entry, &truncated);
>         }
> @@ -187,5 +187,5 @@ void efi_retrieve_eventlog(void)
>                 return;
>
>         efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> -                                  truncated);
> +                                 truncated, final_events_table);
>  }
>
>
>
>
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

