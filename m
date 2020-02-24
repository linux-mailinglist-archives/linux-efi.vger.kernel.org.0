Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C216ABA7
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 17:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBXQd6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 11:33:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727711AbgBXQd6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Feb 2020 11:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582562036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+HqvnuYHetNq0Tag+VCE9fiZvP0g50u+wKBNq+GatA=;
        b=arQmCp17B/dZTVXyFzAWFOjbaEXKQgvBpoZiqnccfUhqg8/dm4aF2IoyKmWOnoxyIN/4Hr
        zbmTBWjOTRIfzQE8/MolLjKgi/IsFNr5BscN534yy1oNLkII4oJNv9z0apBpNLVuDvJ8+N
        GZcPmmQI0ag5ElshYhEDODRWiQJAXo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-_Vnof5yyNVuKsYY80tP8XQ-1; Mon, 24 Feb 2020 11:33:52 -0500
X-MC-Unique: _Vnof5yyNVuKsYY80tP8XQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A37C107BAAA;
        Mon, 24 Feb 2020 16:33:49 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C91E5D9E5;
        Mon, 24 Feb 2020 16:33:45 +0000 (UTC)
Date:   Mon, 24 Feb 2020 17:33:42 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Colin Cross <ccross@android.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-efi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline
 parameter
Message-ID: <20200224163342.d4acf224b56celup@ws.net.home>
References: <20200219162339.16192-1-digetx@gmail.com>
 <20200219162738.GA10644@infradead.org>
 <f9e41108-7811-0deb-6977-be0f60e23b52@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e41108-7811-0deb-6977-be0f60e23b52@wwwdotorg.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 19, 2020 at 09:59:54AM -0700, Stephen Warren wrote:
> On 2/19/20 9:27 AM, Christoph Hellwig wrote:
> > On Wed, Feb 19, 2020 at 07:23:39PM +0300, Dmitry Osipenko wrote:
> > > The gpt_sector=<sector> causes the GPT partition search to look at the
> > > specified sector for a valid GPT header if the GPT is not found at the
> > > beginning or the end of block device.
> > > 
> > > In particular this is needed for NVIDIA Tegra consumer-grade Android
> > > devices in order to make them usable with the upstream kernel because
> > > these devices use a proprietary / closed-source partition table format
> > > for the EMMC and it's impossible to change the partition's format. Luckily
> > > there is a GPT table in addition to the proprietary table, which is placed
> > > in uncommon location of the EMMC storage and bootloader passes the
> > > location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.
> > > 
> > > This patch is based on the original work done by Colin Cross for the
> > > downstream Android kernel.
> > 
> > I don't think a magic command line is the way to go.  The best would be
> > to reverse-engineer the proprietary partition table format.  If that is
> > too hard we can at least key off the odd GPT location based of it's
> > magic number.

 +1

> I thought that the backup GPT was always present in the standard location;

If they have proprietary stuff on begin of the device and valid backup
GPT at the end of the device then designer of this junk is crazy, because
many GPT fdisk-like tools will try to recover from the backup header and 
overwrite the unknown (invalid) stuff at the begin of the device...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

