Return-Path: <linux-efi+bounces-2751-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFECA29A3A
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 20:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528973A7C6D
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D21FF1B3;
	Wed,  5 Feb 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B57nyCL9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C7155335
	for <linux-efi@vger.kernel.org>; Wed,  5 Feb 2025 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784150; cv=none; b=qhFCvuoXkySdiy7D9Q37qT7CcYb2KBWi0B4v6JHM0qFl3JSzce/u+0sEqkehqWAKQgCUVJSMK+c9HRED3vUBAeUeWhY9HliurgvIHRne3pRDPrb09y1ZLsfQy7kj1pn2aeAHhrkd4TiYNCFCvXVbNX2jOdREbjK0K5YyhgtiU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784150; c=relaxed/simple;
	bh=7rmeXiOFyHpHUc2gcEBdx9CMM3a6bCCbvMpYqWexx08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzATNSNDBt4W2O7Q0oMBCYaMAxkpWCgnWB+wa21l0P1HTd3O8SSM4wumiGKl8TqX9M3BDmEa5+x+46wackQnWk51wZdFAMcyPBHP5m82zOVtvo6e7r4oD6h0njfObqeHG5tKrp5hZ9bMk/nwFMKV5ayORnIwfkc/ghu+hQfXJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B57nyCL9; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so1513326d6.3
        for <linux-efi@vger.kernel.org>; Wed, 05 Feb 2025 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738784148; x=1739388948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEv6FH3+8Q9Xxcq199dXGOrCJLqcmfKdGm0I8JED3Qw=;
        b=B57nyCL9AhXYhtMwVGvTNU96zns54sLmY88t0Y2E1nwT9B7IljwGmbHRK6n9RA4A2j
         NFiDmUQoS7jeM493Xg/pgf7fMqjiXqaHzZfFN3scwms944w6zmmvWUaQYMY32maIdIKG
         pdig2tjOjTXAmyAJ4c/RM3FmI7lkSd6dCFnPunqQULBOwNtj+4OqkboDOSMou3SJ2jUi
         JyYAQ54Ljwv6ubKXCbjKwB0xtB+OHPY8UMAfGrBxohnwr8XfBIgJsf/unt2EwblVF6lL
         19iOWjqK1omu1AJBJpdiV2qLm4rq1wqWk6PP5tg3N1Snk+S31CYZDIqN3uKV2si1mdTf
         8VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738784148; x=1739388948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEv6FH3+8Q9Xxcq199dXGOrCJLqcmfKdGm0I8JED3Qw=;
        b=G4NMIzNgjXYXlwYPnyfVEfUKqEgzKEzLuU/PyiHVhaJ+I0yU8pL16JAyzD/aroEvZG
         NQfIjuN7hE2AgVTbLn9K9A85+bbtI4YXLtnxwdTjpIC0GWT+PJS3a3uRfWTNugExRRkq
         iipGtsIqf4f8MmxhGzta+BbkRC5LFWEgcN5gsU1mX0isPcI5PdTDXt4N6fRu5uRz1R9b
         kEdZPcCR1G7Hwx2cj5O7scHuDBAPndKzqP8W9gXKPjiafFHTqrgl0EhMMVfUIbEkP5uO
         oLWyyee4UD/MgfzsXTdnpmnleC765CA9aXraRvpgs1vRFc5nsbHhuKRfc5O1er6XP77k
         CYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfp55wO5a3nvarQB0RGpb9DY1kVLhkYPcEb6PxzEFyRBQWAoc1984YzimOEv+ZKD1hLIjD4xjfvU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPt1vOQKDZLht5SVxoxtxIs+rrapZ3u6QhYw0MQqXyD16TXepR
	zo60I8SmHltRfBBw3Xo6fqOY1ntjzaBRLY5mBTfdpfyL6HDvczWEbDzttkzenco=
X-Gm-Gg: ASbGncuePOHi9DlAV1pqkfDeexaWnOcjZ6I5ifOzqZlNgrajHbfnfwuTnUkkSAZPHII
	qODYs+sJel3A7DAuRJc7rVoUUAA9cKtKDKPrWBjRhg5y5gt0s4Foupiv24nXaZ8/6rK21F54rKp
	jQzfK/yxiC9uzeRRyFXRO9OUasnnobDeKUUFQS+CQbNtwFo1sk7rpyQvk+zoH83ATUm26odwZlO
	f4gymypW7dhRcC+Z95UeUqisP9K6lylKpOzDp1Hu1NjaVKl69Rk8JLmmpuqp8cQIFIaHCHv+9R6
	vAJ6HD/eVquiitnJJWGfP3eNfXSNHZROHt713HZ0J7L0Pp8oqpwUk3+EWZwan0LxotTjVN3XDA=
	=
X-Google-Smtp-Source: AGHT+IEsah4I9S4q0Ze9aL8MG/O/dUCKPZO+7vyWCLiabhjOKyO3me8+KzmnUjKFwsULcJvzrFX+tw==
X-Received: by 2002:a05:6214:4613:b0:6d4:142d:8119 with SMTP id 6a1803df08f44-6e42fcdc639mr53221046d6.42.1738784147737;
        Wed, 05 Feb 2025 11:35:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e42778c9dbsm20875296d6.113.2025.02.05.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:35:47 -0800 (PST)
Date: Wed, 5 Feb 2025 14:35:45 -0500
From: Gregory Price <gourry@gourry.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 4/6] acpi/ghes, cper: Recognize and cache CXL Protocol
 errors
Message-ID: <Z6O9kVCDqiKwQcYi@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-5-Smita.KoralahalliChannabasappa@amd.com>
 <Z6ESAm79OIAQaXM-@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ESAm79OIAQaXM-@agluck-desk3>

On Mon, Feb 03, 2025 at 10:59:14AM -0800, Luck, Tony wrote:
> On Thu, Jan 23, 2025 at 08:44:19AM +0000, Smita Koralahalli wrote:
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index b72772494655..4d725d988c43 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -674,6 +674,56 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
> >  	schedule_work(&entry->work);
> >  }
> >  
> > +static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> > +				   int severity)
> > +{
> > +#ifdef CONFIG_ACPI_APEI_PCIEAER
> 
> #ifdef in ".c" code is ugly. But I don't see a less ugly way to deal
> with this. Moving this elsewhere and adding an empty stub function
> for when CONFIG_ACPI_APEI_PCIEAER isn't configured doesn't make things
> any better.
>

The generally accepted ways I've seen for static funcs in .c is:

#ifdef CONFIG_ACPI_APEI_PCIEAER
static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
{
	...
}
#else
static void ghes_handle_aer(struct acpi_hest_generic_data *gdata) { }
#endif

This at least makes the function that does stuff easier to read and
gives you a spot to throw out a "Config not enabled" error if its
beneficial.

More of a style nit than anything else.


But either way,

Reviewed-by: Gregory Price <gourry@gourry.net>

