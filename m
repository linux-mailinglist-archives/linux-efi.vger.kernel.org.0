Return-Path: <linux-efi+bounces-2750-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E135A299FF
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 20:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0237C3AAD73
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADA81DBB03;
	Wed,  5 Feb 2025 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SBE/+U6p"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4CA204589
	for <linux-efi@vger.kernel.org>; Wed,  5 Feb 2025 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783120; cv=none; b=CUD8zPnpe/drhxOFywhO49RhFR0Vy7P5hBScTtBNB2dAcv3z5a8XgUvACOflu3UFzd+rU4mh7GegqG9rWXHFAmtL9CSod39tlse1Gof+5CJGCbSbcgygcW3mpQzpRA55xv55HDB6XQjmujjb0QAWg9fqHMLt0LlZiR/VxjXX9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783120; c=relaxed/simple;
	bh=oPEtVOpN+aKW2p42nBcWfhpXpIMCi7MvBIh1JiLFbt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoM/otNMdVU/hi36qJknNdVQGuDzXUOlbVVrEQoIvSl56ElgXTnr0hCcnN1TUVWzvJMeQuMREW1kNLR9rSxNwa/Gxgg/wdUCjjLWnVajw0sG/0DKI2ElEfc914uBzsyHbOqydb+PyLVsz0dhukPerluy3jn4e67AcxINh5D5YIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SBE/+U6p; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e429a885f6so2428176d6.0
        for <linux-efi@vger.kernel.org>; Wed, 05 Feb 2025 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738783117; x=1739387917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8qwzDwdGFn2CeBU5qdUptdR+RuNYBJ5DWAN8nwQPu8=;
        b=SBE/+U6pNqiac9f2AE+Mi+L/wB0n9/czpmR4d2yToZX5dDz6kVykMDfofxgKwFg1BH
         L3R61OCJo3JCECKarg02v85VhM3jsj5aQysaK3vkQl/An2GOyZMsnJKnXyG3bdC/x1Mr
         xI7VL7EbZy4ECa4sw1alBxw1vOnCMBkaoNOPZTzmYXRRDuGcT0vgVPrm1gnobXF9My/1
         qL4gf/GX8MsJmtVPb8YeVJzgA1sa/qaSnZ2bnUl20qN7BYErG0vPkhw9adhlldd+RJOm
         c/Gr/lmJ4UixOsDbeZBTJRXIlUD//xUlbq6alXtE8ZxuuDkHvAb0XKjY/jlGxeS8Ixss
         Iq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738783117; x=1739387917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8qwzDwdGFn2CeBU5qdUptdR+RuNYBJ5DWAN8nwQPu8=;
        b=hmVxovDfrKo8fUj5wqtQHdyNbnCSFpNnQYE85FbN6TSjmI/S7Dc1Vv4yLpdd9MV+6U
         cNRI5pFL2z3tp/zhOCcLZX8lb+OJ2Csbxc4+tf6SSdKo59MPQxOfZqtQtrGdKYvnFiBx
         CLnxWh8TjySvMjq6jYiI0GMsGcr/UlxA2FnjQP+BkqoeKMmp82bejVFHG8DKSiD6ToNu
         VwZkqGIckRFnNSX+IXXcViOUiPpsnLlZxiWeQGtWe9gqGp5R6eAUWWturQAetgFdn7qJ
         PnkYxDr4asV8ZadFRMHVMhEH2f2nEz/6YJ90jOiY2q281VakxiGcOAyCx4Sn2l/xDLrm
         oy+Q==
X-Gm-Message-State: AOJu0Ywf4qr19JYyGGOJeiPTB3fmyR/RsN/CG4/vt56hcR6bpBt7jJbu
	fxE6ThdnqimdcJsYjlPXK2+YFdf/Kv3ZQboYhWbC5UC4ULEga/MA37K3FJvq7jA=
X-Gm-Gg: ASbGncuUq+pb4D1Sn/tQa9JvTNK/biDW8tMBRZXiXb9l4OMybGy63T+odlIwfJkgKtF
	jmVWIpeTXz3fs5RMW8JxVxQKatqwqkXq3c6OLEz+Dg5hN6hThQklz+VN3QdyGlaTto3ufr0Ld4K
	X2BayxQeQKtm8zZHGLgnZosrKhkau9SvRi+g5c4mwreeOla6dRi64A+9eY2fZprIm1gM+iT2yLd
	qnqR73Q2nrbebwLZvlEytycxNLc9cxIZvjWekP/31iHINMsIdNiKcQ6o03mAqs8sol9ukb7753c
	Bw7Ib1zKGWSOcw8TY68KJF7tM5QLEbd8Ed4DjFLDUtdIWBjh1UZPLm/kwnLClQB03XuvSvyMsQ=
	=
X-Google-Smtp-Source: AGHT+IFBZGVDEyC791dt6sAmkuAb3iqn/vqzDlTFUXbWrByVqgD+IDHPq9lEi6GiDD3ACBsbSTEaKw==
X-Received: by 2002:a05:6214:e4e:b0:6d8:821d:736e with SMTP id 6a1803df08f44-6e42fc4fc9cmr64862866d6.36.1738783117509;
        Wed, 05 Feb 2025 11:18:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2548141aasm77300476d6.28.2025.02.05.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:18:37 -0800 (PST)
Date: Wed, 5 Feb 2025 14:18:35 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 3/6] efi/cper, cxl: Remove cper_cxl.h
Message-ID: <Z6O5i1ic8lCgKN9z@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-4-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-4-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:18AM +0000, Smita Koralahalli wrote:
> Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
> to avoid maintaining a separate header file just for this function
> declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
> been reorganized.
> 
> No functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

