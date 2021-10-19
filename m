Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6432432E08
	for <lists+linux-efi@lfdr.de>; Tue, 19 Oct 2021 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhJSGWq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Oct 2021 02:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSGWq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Oct 2021 02:22:46 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D3C06161C;
        Mon, 18 Oct 2021 23:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FqiZ0G8l/5kb7F0EMx+Z3dj8VwOY/FdJYLbcI7ewEFQ=; b=PVb/iRNIulJf/rSK99c+aTfwtI
        VA2iIY4W86OKnLzInWBdWuUcktjfFF0eLkDthI0wbTUnTJrm0p3XWQyQBeg/JNaB+7YhDrdIM0zdn
        vKGgSffksNTSjH4E/SqF3YvzMnErLIsE41flOoNtsMwEKH3xh6UU02a2C2g3r31bQJkZnAH79K3dT
        P38VYwWJszxifvzTm6ZX8qY6+3uuVJ6f55gkqaYtVowC6mmmh7PZGYplVmgyqIMSJRuaVnfotRUn2
        QyJvH3yYIbd7/Hv3TlCSwUarLtwmzVgb86FqPwNZPdFer0rBCmAFktnbyoiDQ+29Nr6CcDW6s+0cI
        uEIN0X2w==;
Received: from 089144192247.atnat0001.highway.a1.net ([89.144.192.247] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mciU8-000HLH-Qy; Tue, 19 Oct 2021 06:20:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: more bdev_nr_sectors / bdev_nr_bytes conversions
Date:   Tue, 19 Oct 2021 08:20:21 +0200
Message-Id: <20211019062024.2171074-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jens,

these somehow slipped into a different branch, so here is another
small batch.

Diffstat:
 ioctl.c          |   20 ++++++++------------
 partitions/efi.c |    2 +-
 partitions/ibm.c |   19 ++++++++++---------
 3 files changed, 19 insertions(+), 22 deletions(-)
