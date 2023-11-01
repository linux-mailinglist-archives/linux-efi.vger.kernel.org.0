Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8461B7DE568
	for <lists+linux-efi@lfdr.de>; Wed,  1 Nov 2023 18:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344405AbjKARgI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Nov 2023 13:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbjKARgH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Nov 2023 13:36:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D926C1;
        Wed,  1 Nov 2023 10:36:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SLDfh1WTxz6K8xG;
        Thu,  2 Nov 2023 01:35:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 1 Nov
 2023 17:36:00 +0000
Date:   Wed, 1 Nov 2023 17:35:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v2 3/3] cxl/memdev: Register for and process CPER
 events
Message-ID: <20231101173559.0000112c@Huawei.com>
In-Reply-To: <654135c4f3e0_2e75b2949e@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
        <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
        <653aee8ad2717_780ef29418@dwillia2-xfh.jf.intel.com.notmuch>
        <654135c4f3e0_2e75b2949e@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Oct 2023 10:13:40 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Dan Williams wrote:
> > Ira Weiny wrote:  
> > > If the firmware has configured CXL event support to be firmware first
> > > the OS can process those events through CPER records.  Matching memory
> > > devices to the CPER records can be done via the serial number which is
> > > part of the CPER record header.
> > > 
> > > Detect firmware first, register a notifier callback for each memdev, and
> > > trace events when they match a device registered.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >   
> > [..]
> > 
> > The changes requested in patch2 cover all of the comments I currently
> > have on this patch, just one more cleanup below:
> >   
> > > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > > +int cxl_cper_event_call(struct notifier_block *nb, unsigned long action, void *data)
> > > +{
> > > +	struct cxl_cper_notifier_data *nd = data;
> > > +	struct cxl_event_record_raw record = (struct cxl_event_record_raw) {
> > > +		.hdr.id = UUID_INIT(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
> > > +	};  
> > 
> > Just do:
> > 
> > 	struct cxl_event_record_raw record = { 0 };

FWIW (I'm in a pedantic mood), unless you care about that specific 0
= {};
equally valid.
c99

"If there are fewer initializers in a brace-enclosed list than there
are elements or members of an aggregate ...  the remainder of the
aggregate shall be initiali\ed implicitly the same as objects
that have static storage duration."

i.e. to 0.

Nothing says that fewer != 0 ;)


> > 
> > ...and the compiler will take care of the rest as initializing any field
> > automatically initializes everything else to zero.  
> 
> Not quite sure what I was thinking.
> 
> This works better but I think I can avoid needing this initialization all
> together by reworking the structures.  For now I have made the change and
> I'll see how it falls out.
> 
> Thanks,
> Ira
> 

