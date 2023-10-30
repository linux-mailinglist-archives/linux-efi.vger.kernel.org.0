Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F058A7DBE62
	for <lists+linux-efi@lfdr.de>; Mon, 30 Oct 2023 17:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjJ3Q6V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Oct 2023 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3Q6U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Oct 2023 12:58:20 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35A98;
        Mon, 30 Oct 2023 09:58:17 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B08969040AF;
        Mon, 30 Oct 2023 16:58:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a298.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4573A904247;
        Mon, 30 Oct 2023 16:58:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1698685096; a=rsa-sha256;
        cv=none;
        b=ctYRvmt764plHB540hgKnJpkBfT140eYspLuZX0epybnSSWBnYj5k3xoaMEKZnDDvg/9YG
        MJX3TXblkRZB9JzYLBZo9fBBG1gnTG/AnflDbua+11VbJsp+Cb4lZH96Gbe0cJOZ3q0cs8
        qKOH/arlZjKfTCxciAdCKh/uxxO20o7W7Tm1NINdiM+owufUP+M6Bw/ml04MqByO/bWbDA
        Ite+Szuk27MVm6CV2ecuOD9lh9JbVDIpvN4QkVpu4V4CdvsUpsZhDJHFTKb055l4Mqvihv
        h5rEyt98uWY7Z/2ZvbkYFPHKHIJVUYFgmPSLTvFihb+6qMd/Jg6dLEF3nF1V5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1698685096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KMsycX8n74GZ4OJVdVYpbTK2S7jA69Zgk4Q2KDDXe4k=;
        b=bKeIuAS5befT8W960sChhXqGG784AIhqzCfAcmXzPYG4JzwzdPCw5xPnpyFau2MWFsKIUF
        F/spyCcAxHQg9KSrEM/10uVhEs7BnwBxA0oKShVWJHY93pKaH698e3/r6Czlz5D5lxyyEt
        yeF7s8tmji4uG6LG9a+wgEJvecyTFWKDf14AtPY1gmRsRsXRVp4L5ZBYNfmTqU35aKkFRU
        GtD4aHNShtgdhkR4pzYHph33Zvodk+6jf4JcVgeZnFXuPyO3bOERBLjGKqdFBfwY7edAl/
        c4hTvcar1SpYWXY9OXt+LZV4A0ioN5EhPaz3yAMJCnjPSPXgQlxarzL454RTRA==
ARC-Authentication-Results: i=1;
        rspamd-79d8cddc67-48wg5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Continue: 65620856089d169d_1698685096500_957299102
X-MC-Loop-Signature: 1698685096500:2414897907
X-MC-Ingress-Time: 1698685096500
Received: from pdx1-sub0-mail-a298.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.178.160 (trex/6.9.2);
        Mon, 30 Oct 2023 16:58:16 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a298.dreamhost.com (Postfix) with ESMTPSA id 4SJzx331F8zRG;
        Mon, 30 Oct 2023 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1698685096;
        bh=KMsycX8n74GZ4OJVdVYpbTK2S7jA69Zgk4Q2KDDXe4k=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TvEnCzxp6sYERkRFHbIqqEqrc2iIvIU8WrcjtYoI2VrzGdwtEjMirnxs0suCyWKYa
         pjaksSPDE6tZmB9RVjqsNJGo7xDZaLTffMgtD7RSs/TakmmPgzaBiNij3/7TATCFbc
         zt2HIQ4o47SYb84EGhtW6Wb4H0sQZRNayl75h8kBpNGcwxuV5e7cACHrhgbGA0Z1HY
         8DYq2SI0/rCmA1tZHHSW0TysrCB+LGiB1ZpeAw3MrnkBOKjOQwq68aDfxerK9QbyIX
         8KVPaJ2MfLhSPwEZVMzEhR6eYVi00T1OggKAutnCWvtUYLcMGdiuO+mZ94Njg746G3
         TreLuko+/Ylwg==
Date:   Mon, 30 Oct 2023 09:58:12 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/3] cxl/trace: Remove uuid from event trace known
 events
Message-ID: <7g6w7ofbhzbjvoday4a6ld5ww5tewfb6lgnc5hncnsfowbxi2w@tbym33zcaxrj>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-1-314d9c36ab02@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v2-1-314d9c36ab02@intel.com>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 26 Oct 2023, Ira Weiny wrote:

>The uuid printed in the well known events is redundant.  The uuid
>defines what the event was.
>
>Remove the uuid from the known events and only report it in the generic
>event as it remains informative there.
>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
