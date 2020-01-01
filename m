Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE312DD7C
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 04:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgAADYK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 22:24:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25631 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727132AbgAADYK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 22:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577849049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fv/kC8iDABf6sLfJmiILU6rh8XitUBjaUMc9ljl9uGs=;
        b=bo2Og8iACrzdf81J0a6xspza0FeSLe9Gnqj5NlYKzrPgjQ3WJxp8hpKStinOcSJz/vgLps
        5JKTl8A7ILUsYI3Flf/I3eFHl6kE6G6qQ/hNLtbiHq55nxyWt6j5N9Gi2VKrCrAx8/BhTl
        c+2DfgIZOrNAqFE6av9OO4VXhTP0Rrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-YecvINgbMrm6ZQxKgbv6vQ-1; Tue, 31 Dec 2019 22:24:05 -0500
X-MC-Unique: YecvINgbMrm6ZQxKgbv6vQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A58A7800EB8;
        Wed,  1 Jan 2020 03:24:03 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81CA660BE2;
        Wed,  1 Jan 2020 03:23:59 +0000 (UTC)
Date:   Wed, 1 Jan 2020 11:23:55 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH] efi: Fix handling of multiple contiguous efi_fake_mem=
 entries
Message-ID: <20200101032355.GA14346@dhcp-128-65.nay.redhat.com>
References: <157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191231014630.GA24942@dhcp-128-65.nay.redhat.com>
 <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4heY1CKAWo1AKKifYUtXdKjoUt45dZbCNhB2o59hkXY6g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> Perhaps a prettier way to do this is to push the handling of each
> efi_fake_mem entry into a subroutine. However, I notice when a memmap
> allocated by efi_memmap_alloc() is replaced by another dynamically
> allocated memmap the previous one isn't released. I have a series that
> fixes that up as well.

Yes, agreed, thanks for the fix:)

