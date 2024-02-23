Return-Path: <linux-efi+bounces-655-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A8686129C
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 14:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813D71F2474A
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81827CF07;
	Fri, 23 Feb 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3M2njpe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA17AE78
	for <linux-efi@vger.kernel.org>; Fri, 23 Feb 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694735; cv=none; b=JdqnDO3RmC+CZag0heN+Bbit52fs2Nzw0a+bROKKSmTzy0lKd9K8SUqLmEAzQMAl4GtODOz0yWz/ZtayDDyqp/OWjPnUYqOVNPI8EdBGvCyqeibSMzpqu7DI2gplnarOd8pRy18GF52Pytr2HNtQdPTrxgCo9FGukvMddbfIqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694735; c=relaxed/simple;
	bh=8W2YjE8PwlPeNRufHAAQFYoxCLTiN7XteQ72PTA9h8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TD5+WUvbKzOiprE0m+8p5ZHKOGp9HOsvlCwNoTH3yr/vO9h+b0oGCsJYDMJ5ndcDGFHTzvsCn8XeyJ2Zn3ecXHbcC+IxsQ+C4hJ/6Zuf50ybeehnqCTif7fXTKgG8cRdntyoIuahV8sw2LQ8FVNZ8MTIbNghXij7S4GhBwMqFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3M2njpe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512b13bf764so1134001e87.0
        for <linux-efi@vger.kernel.org>; Fri, 23 Feb 2024 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708694732; x=1709299532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19cp42f8tFvnJXMehM3M7grgDYIRgHH0G4ve9idhWWk=;
        b=o3M2njpeL/tuzIO1oFzZzMJCpD6Hdk2fJVFhpyePe0qsHq3kgJNe3b8Nb1dbrDiGnE
         OzTj67DixlT4sA+hBBy5btC/RA0+SdwksT7ls/pI25X6fBIyRwk76XJLV39RuceE9BIf
         AM4YcfdCCELHtcMk24265lwTnhZcmWGKB1MP/AnmM3zbm5cByVZUYSOOIX6k9GuDrfjn
         766Zd/CjS6XvNchU30aIn6vHso/WgDiM7FvfZzLVqppwVyMkjrC9ROJvIueSFlkqfSEx
         1KUGLksiucro09yn8O+qzqZv8Arv7ivZyBLmSdNOp+SD8nj4Li61BNgdkVlBy9FkBWaw
         oX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694732; x=1709299532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19cp42f8tFvnJXMehM3M7grgDYIRgHH0G4ve9idhWWk=;
        b=v7ZGq5XQz6MZvTgoF5TtxO0FEa1vRQq8lWBFrcX13YGetHxxH8dgDoyx6xDAREEIVa
         vFeMV5HtsI6htzea49qCEQCl6/LSiu3lYMOaV+7pZJkC5Rvjb+2shfF3pTBgwIv/1v7h
         KZPp7D7K1yh9gVPXdVKmBqJ1Fvq4QKqqGtrcpIKgMX7oKt5UjeuJpVKAY0/Jjvvx2UgY
         QLmttrmWq2dMwTrCaaOmz3wQjgkFKD8uVMoA6QNuybSDVjM6blDAKWA9wxWYXbtpm3Xj
         KT85pwXDP6warrGY6jgtGkGOdJqzRy5t5ax5KHHHHQJ5v0bJ5M74dgAcy/2QCUi2VfQl
         GiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBd2+9ndJ0GMlXzNxZuArVOn/L5O5iqytfQE+/V/8aRkfvdzLPEzATZPXNDI8yAeDo7aTf/qw0z4/9BRCRfYuAJ2rSiUAbdGYW
X-Gm-Message-State: AOJu0YydNnCbljKAAUbU9be1fND2yzwb6yZXfpXFCOLneyo0umdV/a1m
	OzYEl+xdReFL3C5a/zzhvaE63ZpMuY7kbPHrJBVxTBoik92fFpM0jI/PTJAuACo2oHxCIaKgDfG
	xZn96upJ1TixfOxCyyiaLf2jL4sZ+Q1VQPI7eAQ==
X-Google-Smtp-Source: AGHT+IGAR/bF+42kR+hM0mMtSuGMWvJoLo2qwVPBAxda+Xy6v3FF+h6fREGI2CjWkB52iKh+m7RhPE5UXlpnJKKzfz8=
X-Received: by 2002:ac2:5d48:0:b0:512:df5b:ee91 with SMTP id
 w8-20020ac25d48000000b00512df5bee91mr1425719lfd.30.1708694732339; Fri, 23 Feb
 2024 05:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240215030002.281456-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAC_iWjJ_TS66KG7uGOQFiKGfZNKjnod6u7zua4LVK-EJHEUv8w@mail.gmail.com> <7feb889f-f78e-4caa-a2f4-9d41acf6ca76@linux.intel.com>
In-Reply-To: <7feb889f-f78e-4caa-a2f4-9d41acf6ca76@linux.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Feb 2024 15:24:56 +0200
Message-ID: <CAC_iWj+9eWesWD62krdhLwj58fpjptpnnG5JpUJUpFsg7_GzOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: Add get_event_log() support for CC platforms
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Apologies for the late reply,


On Mon, 19 Feb 2024 at 09:34, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Ilias,
>
> On 2/18/24 11:03 PM, Ilias Apalodimas wrote:
> > On Thu, 15 Feb 2024 at 05:02, Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >> To allow event log info access after boot, EFI boot stub extracts
> >> the event log information and installs it in an EFI configuration
> >> table. Currently, EFI boot stub only supports installation of event
> >> log only for TPM 1.2 and TPM 2.0 protocols. Extend the same support
> >> for CC protocol. Since CC platform also uses TCG2 format, reuse TPM2
> >> support code as much as possible.
> >>
> >> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#efi-cc-measurement-protocol [1]
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > [...]
> >
> >> +void efi_retrieve_eventlog(void)
> >> +{
> >> +       efi_physical_addr_t log_location = 0, log_last_entry = 0;
> >> +       efi_guid_t cc_guid = EFI_CC_MEASUREMENT_PROTOCOL_GUID;
> >> +       efi_guid_t tpm2_guid = EFI_TCG2_PROTOCOL_GUID;
> >> +       int version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
> >> +       efi_tcg2_protocol_t *tpm2 = NULL;
> >> +       efi_cc_protocol_t *cc = NULL;
> >> +       efi_bool_t truncated;
> >> +       efi_status_t status;
> >> +
> >> +       status = efi_bs_call(locate_protocol, &tpm2_guid, NULL, (void **)&tpm2);
> >> +       if (status == EFI_SUCCESS) {
> >> +               status = efi_call_proto(tpm2, get_event_log, version, &log_location,
> >> +                                       &log_last_entry, &truncated);
> >> +
> >> +               if (status != EFI_SUCCESS || !log_location) {
> >> +                       version = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> >> +                       status = efi_call_proto(tpm2, get_event_log, version,
> >> +                                               &log_location, &log_last_entry,
> >> +                                               &truncated);
> >> +                       if (status != EFI_SUCCESS || !log_location)
> >> +                               return;
> >> +               }
> >> +
> >> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> >> +                                          truncated);
> >> +               return;
> >> +       }
> >> +
> >> +       status = efi_bs_call(locate_protocol, &cc_guid, NULL, (void **)&cc);
> >> +       if (status == EFI_SUCCESS) {
> >> +               version = EFI_CC_EVENT_LOG_FORMAT_TCG_2;
> >> +               status = efi_call_proto(cc, get_event_log, version, &log_location,
> >> +                                       &log_last_entry, &truncated);
> >> +               if (status != EFI_SUCCESS || !log_location)
> >> +                       return;
> >> +
> >> +               efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
> >> +                                          truncated);
> >> +               return;
> >> +       }
> >> +}
> > [...]
> >
> > I haven't looked into CC measurements much, but do we always want to
> > prioritize the tcg2 protocol? IOW if you have firmware that implements
> > both, shouldn't we prefer the CC protocol for VMs?
>
> According the UEFI specification, sec "Conidential computing", if a firmware implements
> the TPM, then it should be used and CC interfaces should not be published. So I think
> we should check for TPM first, if it does not exist then try for CC.

Ok thanks, that makes sense. That document also says the services
should be implemented on a virtual firmware.
I am unsure at the moment though if it's worth checking that and
reporting an error otherwise. Thoughts?

Thanks
/Ilias
>
> https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#confidential-computing
>
> > Thanks
> > /Ilias
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

