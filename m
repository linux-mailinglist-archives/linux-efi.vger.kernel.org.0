Return-Path: <linux-efi+bounces-4693-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2264B448AF
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 23:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661D61CC1C8E
	for <lists+linux-efi@lfdr.de>; Thu,  4 Sep 2025 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863D2C15A3;
	Thu,  4 Sep 2025 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9Abxpzu"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3AC2C158A
	for <linux-efi@vger.kernel.org>; Thu,  4 Sep 2025 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021918; cv=none; b=LQsPASkkLJqbjIJuSgPR3SdCuwlhYyBtoEvlSu6WpTy4XIcSOZQPX2mJFg5jWr8dHxXGJX3FJfmwtFd7U4JYJ0LVl8EGBQoD7dYDMwXNR9mWZH99QoW6AF0SHLgzVOizvK8ER/KX/LQoNMEVZ30mB1OKV6CKLwvYavNvojBLeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021918; c=relaxed/simple;
	bh=+ZrUvtnLM9xSVjfFb/jug+Mxt/vh9q4WYgIFgX9cQDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC4juAFxqlsEOCHiIAH9LbbICeB5D+2h3Aykrs+jByvNBVDPFGWIOlElIwRmVGyz1fjnCY92BqJ24YSB0GjQ8vDpBUXlJS73SD0IRjWFX756rgSjPRo/dSy3pxrI8rb7Di4K7b81dQGLMYvIR+4hsHk+FMbmoWKfaebBX6ZgkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9Abxpzu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9rHD7plJVEZkv8PkFJEx5BeBVBt5QFBtzvV5bLJfU1s=;
	b=e9AbxpzukcoKaOXSeXcp2w3w7k2MS+2IyhSpbfnhUREQ0UIZ7BCE9qj1yqrtxOdSrvzjTC
	YPGkhDyA76fdqF+amJQ3SE2d/QTdtu/tmsliab5J2tRhxI89SVzLzsByv5Ijve04EkS0du
	meZvvHlh2Zv+1cNBUPG2Y5DjPFA8Y5c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-iksGrodcN5eiAvzyZNOL6g-1; Thu, 04 Sep 2025 17:38:34 -0400
X-MC-Unique: iksGrodcN5eiAvzyZNOL6g-1
X-Mimecast-MFC-AGG-ID: iksGrodcN5eiAvzyZNOL6g_1757021913
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b87609663so8517385e9.3
        for <linux-efi@vger.kernel.org>; Thu, 04 Sep 2025 14:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021913; x=1757626713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rHD7plJVEZkv8PkFJEx5BeBVBt5QFBtzvV5bLJfU1s=;
        b=dIkoaj/yRaHlfDQpM58SvKC2tJqyLBt5jxl/UzMFYdkB/Ve6kYPxsZjbgWZPp/k++4
         aG0glhxkGQeSVu+Mktx8HAcuNfeX8d/+zmCruUTUgNEmNvn27RdFCqe8UZPMIefLSJap
         0WbiE5N6rZpwX3Gd7xjvdbUniEwb6f3oqDGSYu2hLcEql7h48ftv2if92UjmTO7WB3qi
         qgmCDnWS4YO3dim0RslcFd4FGytKLaNaueaTHwFWnWwU2uLs2ZlePbVC3UKxETuzQS/L
         A/2msPQfh9TItlNddtOr80X2/3WSy4OAREYRYzq6wDvUSJ8FDLyXwNF9ZQPODHu32nvj
         OemA==
X-Forwarded-Encrypted: i=1; AJvYcCWLZCQnHfGJUnJbAH4pkcWZI3ZSvgO64XkecVWlh8TONlLBPl1UjJcqRdOsI9HKYDtFeNOM+GRqNdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/5O7MGH+6a/ubLa+WlM0xUylRu3Vq1iB/aKBd2xlBVC98Q9c
	g/5zkdOs2+//cTfxuWkKu2lcGFMDcw/akQiDt0bOdtneED7IlsK2UReXkbGwZoVU6ud8MXcCU8V
	e7kkiJUTiehdk5bgIPfEf2F21y1uC6q2GlLrznkXVwLW+2ZHU10Phzmtb8u6HWA==
X-Gm-Gg: ASbGnctS5Uz7qVXL/HH+/3PDXu4x/r4SYvkVRbNx2ygrCPeqGU7NkRzBg7sz5TBVWnD
	oV639nDzNvk8xQMt6LIokNZQqRGyQW2KLZWHzq4HdiYnITep7lFJgO65Wafxjlrk5x5dqZ5BBBq
	RCx48C4oIK+RRRZDMFSa/Kb+DhUGEofFg2kkrU8XDGYfKuhtmfshcA6fcUOaY/ZX7CzMiycMmUs
	rhLTDEV5/dnymIpFU2u0/AvLTsB+8fuNZGIbdxZA3U1uiNM5B0hnAhQKzMneL0P4Pz9GDg+vWpz
	oLYD0EJL5Yy8BwhEVmIAd/7gNTpFASNl8kZJbSj+i3Xwsutlap8lnyz1Y97RgNk5GA==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id 5b1f17b1804b1-45b891fb24dmr144597895e9.27.1757021913371;
        Thu, 04 Sep 2025 14:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWbBDlkpyRRxeIt/+qH4VagktWDBCJazVbSXDHRMhx/diXSZUFSBaQ6M24PtRDNYL0yu7m/g==
X-Received: by 2002:a05:600c:1d10:b0:45b:891f:afcf with SMTP id 5b1f17b1804b1-45b891fb24dmr144597725e9.27.1757021912965;
        Thu, 04 Sep 2025 14:38:32 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67fsm1872200f8f.62.2025.09.04.14.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:38:32 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:38:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
Message-ID: <20250904173824-mutt-send-email-mst@kernel.org>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-8-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903185921.1785167-8-vishal.moola@gmail.com>

On Wed, Sep 03, 2025 at 11:59:21AM -0700, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_balloon.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index eae65136cdfb..7f3fd72678eb 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>  		page = balloon_page_pop(&vb->free_page_list);
>  		if (!page)
>  			break;
> -		free_pages((unsigned long)page_address(page),
> -			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  	vb->num_free_page_blocks -= num_returned;
>  	spin_unlock_irq(&vb->free_page_list_lock);
> @@ -719,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  	if (vq->num_free > 1) {
>  		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
>  		if (unlikely(err)) {
> -			free_pages((unsigned long)p,
> -				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  			return err;
>  		}
>  		virtqueue_kick(vq);
> @@ -733,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  		 * The vq has no available entry to add this page block, so
>  		 * just free it.
>  		 */
> -		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>  	}
>  
>  	return 0;
> -- 
> 2.51.0


