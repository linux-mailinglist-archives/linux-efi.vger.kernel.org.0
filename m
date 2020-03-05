Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37453179FDC
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 07:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgCEGRg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 01:17:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23690 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbgCEGRf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 01:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583389055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6xu+5UxvlRGBObBERKpxsZYB1W/AKSUkfhw6bHB3FM=;
        b=UcqGQlRv9RSyp+wc3GoY798GYPY2yOfh765BzB1dag0mtH/AE/UMflm6JT8GL4UcBT8Vfs
        Yy3w648ewf9je9HUZdwBMepbxB2EdzXcUd47f4JLKEcesbcUhEsHtIkIAxqYcXwp/sxIpp
        KJdyCVd1TGflRHrdSaBl9+JyyMxKSA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-fVRD406aNJWJE02WSIVI_w-1; Thu, 05 Mar 2020 01:17:30 -0500
X-MC-Unique: fVRD406aNJWJE02WSIVI_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C553813E4;
        Thu,  5 Mar 2020 06:17:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1A1319C6A;
        Thu,  5 Mar 2020 06:17:29 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A12DA1809563;
        Thu,  5 Mar 2020 06:17:29 +0000 (UTC)
Date:   Thu, 5 Mar 2020 01:17:29 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     joeyli <jlee@suse.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <1322502214.13237657.1583389049605.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200305060123.GS16878@linux-l9pv.suse>
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com> <20200304154936.24206-1-vdronov@redhat.com> <20200305060123.GS16878@linux-l9pv.suse>
Subject: Re: [PATCH v2] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.88, 10.4.195.7]
Thread-Topic: fix a race and a buffer overflow while reading efivars via sysfs
Thread-Index: yZpuewxX2bAsD2i1VoJ9lfrdXAYJYw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello, Joey, all,

> > -	var->DataSize = 1024;
> > -	if (efivar_entry_get(entry, &entry->var.Attributes,
> > -			     &entry->var.DataSize, entry->var.Data))
> > +	ret = efivar_entry_get(entry, &var->Attributes, &datasize, var->Data);
> > +	var->DataSize = size;
> 
> The size is indeterminate here. I think that it should uses datasize?
> 	var->DataSize = datasize;

Indeed, my mistake. Thank you much! I will fix it in the v3 patchset I'm
currently composing.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

