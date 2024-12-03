Return-Path: <linux-efi+bounces-2265-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE829E1C61
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 13:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D0B16723F
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2024 12:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D621C1EBA00;
	Tue,  3 Dec 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Unb6vnj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475011EB9F0;
	Tue,  3 Dec 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229675; cv=none; b=fqUWbwLL4gIf1GsLJsID+AYIdQ6AQ0OZIk4C01SmleA9Gco6Rin9a4ZBPZZ07SKRjCf8baKRKTzA5au8anGnukmppcSZdgsRv0v4B86iQQRu+oeb3GZgHv7cpQ/anc/F2b4UljlLu2Wo0ZgI2qRekpKUTVKdMxSZLx5seWmPZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229675; c=relaxed/simple;
	bh=2uEXSo5be+RCYE8wBlDOJXNuB/VT7ARg3i3C+zGOWYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlgiALEaVTYJdwlQ3ce2Hd+GUHfNwe3ZiCAhKF6n6B6SU3Tyi0963R3QVHbVGlJen2i8VyCF6DO98sGU3X/bXBNG8oupkQIMV0KkOVfn1E0OQokbt2HoFFmqCTY266A8c0VclDaFij8a2F6h1AUOKS3GEewqvjBityvYGWYIN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Unb6vnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C16C4CECF;
	Tue,  3 Dec 2024 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733229675;
	bh=2uEXSo5be+RCYE8wBlDOJXNuB/VT7ARg3i3C+zGOWYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Unb6vnj0waeqg52vL3tNBxqazZ4YLEkRH6amdDr2bx43L5JPTkkH+pB+L4tMzH0J
	 SCb6eYmqeMGHbFRdUm9eKf56OQESdHkQFoMknfazShRPcJP62eT8Z3A5bIfaHIyzv7
	 mcuUv99lpsVEKyYu6Ycjcf2lp80AbgdlAJGG1ZwM=
Date: Tue, 3 Dec 2024 13:41:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jiri Slaby <jirislaby@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Jens Axboe <axboe@kernel.dk>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pwm@vger.kernel.org, nvdimm@lists.linux.dev,
	linux1394-devel@lists.sourceforge.net, linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org, open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org, linux-cxl@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-block@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 00/32] driver core: Constify API device_find_child()
 and adapt for various existing usages
Message-ID: <2024120320-manual-jockey-dfd1@gregkh>
References: <20241203-const_dfc_done-v2-0-7436a98c497f@quicinc.com>
 <g32cigmktmj4egkq2tof27el2yss4liccfxgebkgqvkil32mlb@e3ta4ezv7y4m>
 <9d34bd6f-b120-428a-837b-5a5813e14618@icloud.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d34bd6f-b120-428a-837b-5a5813e14618@icloud.com>

On Tue, Dec 03, 2024 at 08:23:45PM +0800, Zijun Hu wrote:
> On 2024/12/3 20:00, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Tue, Dec 03, 2024 at 08:33:22AM +0800, Zijun Hu wrote:
> >> This patch series is to constify the following API:
> >> struct device *device_find_child(struct device *dev, void *data,
> >> 		int (*match)(struct device *dev, void *data));
> >> To :
> >> struct device *device_find_child(struct device *dev, const void *data,
> >> 				 device_match_t match);
> >> typedef int (*device_match_t)(struct device *dev, const void *data);
> > 
> > This series isn't bisectible. With only the first two patches applied I
> > hit:
> 
> yes. such patch series needs to be merge as atomic way.
> 
> Hi Greg,
> 
> is it possible to ONLY merge such patch series by atomic way into your
> driver-core tree?

Nope!

> or squash such patch series into a single patch ?
> 
> various subsystem maintainers may not like squashing way.

Agreed, so look into either doing it in a bisectable way if at all
possible.  As I don't see a full series here, I can't suggest how it
needs to happen :(

thanks,

greg k-h

