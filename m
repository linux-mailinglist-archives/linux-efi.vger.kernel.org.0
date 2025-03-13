Return-Path: <linux-efi+bounces-2980-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAFFA5E92C
	for <lists+linux-efi@lfdr.de>; Thu, 13 Mar 2025 02:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011791896A84
	for <lists+linux-efi@lfdr.de>; Thu, 13 Mar 2025 01:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC8134AC;
	Thu, 13 Mar 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Qv19dkBB"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577E610C;
	Thu, 13 Mar 2025 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827850; cv=pass; b=EBToTX8yHquM8FpCOJm3cidurztPE3ga2gueH1lGZ2hGceL7BYAHLQG6NKf5zYExEjiwYnTftYdMG59YNrQ7ySfJNDE259SieCL1vzcjDlvMQ+cvs9aOy0VIYXNRwJFm7NiP8AZAKGHwPh6ZX1EkVfCFl/HNk56taFHEzhkeiz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827850; c=relaxed/simple;
	bh=ptb1yCGQ4eC7RLKos73sOEELe/orMTxmvpyeLMtCFl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMEU9uB4SGPj8ixVTcB16KXVQ9nRnntli6Q2zOj16SnyBqU+Wq1FaXx+9AfIBWVj+PSNPGdm7HUIl66sMx9jL6Wqro6OLr4thjmuX0dCh92Wy1F8iCldpWF/BfSlq0L0H28cOUlDTLlhxBtfCeGf3TjMSCmAbqE07gXB+UMJ//g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Qv19dkBB; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1741827833; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LSakLUeVxsKSb0zO1w7LB1dZTZqIDAoWyYGKHJCkVoQv0FnTDfTce+ZLNxe6K7JnNTm/zajbeuIkTs03qvRWRigLimH1877YOl1ahWdbl60T5ztn/l66hobGE+aNskRxyBNn+kmf7Ou3jJWLpdmNfYS0AXhF9meWL+4YTLQe9iU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741827833; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ptb1yCGQ4eC7RLKos73sOEELe/orMTxmvpyeLMtCFl4=; 
	b=JfA8pR0fc0lyoRw8VR7OszJPsEpLmJrPdEt3ufJzFZT6orPCrewUpn/Iw5SauCf3YEgLdFaLLVpFFQ9SIXnJqh39Cjo6gWOtvB1Nk7qE8OgtXI1CgRvuq45Y78GH1Lw7Kje2yKFsg0K40rKxqj7J2MhYje6Gs5kUI7aUa+nq0Sg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741827833;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ptb1yCGQ4eC7RLKos73sOEELe/orMTxmvpyeLMtCFl4=;
	b=Qv19dkBBwjfRenbEyZ/HL9jDH1WWdcKYNMSebaRN3xWaTFr0Lo5I/BaesSafZWlO
	WTPn0srAkoD9qw8VH7u7nLo1xDPKRCD2eMTgiXegZ60YIiwKW2uFano9M5WBJTKWvQx
	lQrvr5/0LMu6CyTQ4HsNj4Mignkg0xLGznssyeLc=
Received: by mx.zohomail.com with SMTPS id 1741827829825799.672780763442;
	Wed, 12 Mar 2025 18:03:49 -0700 (PDT)
Message-ID: <4f4e317d-58b2-4059-b112-3c1b78318bbe@zohomail.com>
Date: Thu, 13 Mar 2025 09:03:48 +0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20250310223839.31342-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250310223839.31342-3-Smita.KoralahalliChannabasappa@amd.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250310223839.31342-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112270e82c9f0dc2504648a7b86170000d92694ecc7679e2082b24297b4cabd468975f129665d0a3483:zu080112279b589e74fc085fca390b28310000849fe36478de3f69138160128452bed8fe068e39b2cc6f6241:rf0801122db6a371974be10396513b27d9000082f3925b01915223fb5e2e15a2baadc78ffc94e3afb39c24f3d5c03c2307dd:ZohoMail
X-ZohoMailClient: External

On 3/11/2025 6:38 AM, Smita Koralahalli wrote:
> The CXL drivers use kernel trace functions for logging endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
>
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Use them to trace
> FW-First Protocol errors.
>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>


